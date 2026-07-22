// Generate a best-of-3 Gen9 random-battle series between two random-move agents.
// For each game it writes the spectator protocol log (for rendering) and records:
//   - both teams' full movesets  -> the closed vocabulary shown to the agent
//   - the per-turn move ledger    -> the ground-truth answer key
// All seeded from one base seed, so video and answer key can never drift.
//
// Usage: node gen_series.js <baseSeed> <outDir>
//   writes <outDir>/game{1,2,3}.log and <outDir>/series.json
'use strict';
const fs = require('fs');
const path = require('path');
const Sim = require('pokemon-showdown');
const { RandomPlayerAI } = require('pokemon-showdown/dist/sim/tools/random-player-ai');

const baseSeed = parseInt(process.argv[2] || '7', 10);
const outDir = process.argv[3] || '.';
fs.mkdirSync(outDir, { recursive: true });

function seedFor(g) {
  const s = baseSeed * 100 + g;
  return [s & 0xffff, (s * 7 + 1) & 0xffff, (s * 13 + 2) & 0xffff, (s * 17 + 3) & 0xffff];
}

function moveName(id) {
  const m = Sim.Dex.moves.get(id);
  return m && m.exists ? m.name : id;
}

function playGame(g) {
  return new Promise((resolve) => {
    const prng = seedFor(g);
    const stream = new Sim.BattleStream();
    const streams = Sim.getPlayerStreams(stream);
    const spec = { formatid: 'gen9randombattle', seed: prng };
    const p1 = new RandomPlayerAI(streams.p1, { seed: prng });
    const p2 = new RandomPlayerAI(streams.p2, { seed: prng });
    p1.start();
    p2.start();

    let log = '';
    (async () => {
      for await (const chunk of streams.spectator) log += chunk;
      // battle done: extract teams from the underlying battle object
      const battle = stream.battle;
      const sideNames = { p1: 'Red', p2: 'Blue' };
      const teams = {};
      for (const key of ['p1', 'p2']) {
        const side = battle.sides[key === 'p1' ? 0 : 1];
        teams[sideNames[key]] = side.pokemon.map((p) => ({
          species: p.species.name,
          moves: p.moveSlots.map((m) => moveName(m.id)),
        }));
      }
      // parse the per-turn move ledger from the spectator log
      let turn = 0;
      const moves = [];
      for (const line of log.split('\n')) {
        const f = line.split('|');
        if (f[1] === 'turn') turn = parseInt(f[2], 10);
        else if (f[1] === 'move') {
          const side = f[2].slice(0, 2) === 'p1' ? 'Red' : 'Blue';
          moves.push({ turn, side, move: f[3] });
        }
      }
      let winner = null;
      const mwin = log.match(/\|win\|([^\n]+)/);
      if (mwin) winner = mwin[1].trim();
      fs.writeFileSync(path.join(outDir, `game${g}.log`), log);
      resolve({ game: g, seed: baseSeed, teams, num_turns: turn, winner, moves });
    })();

    void streams.omniscient.write(
      `>start ${JSON.stringify(spec)}\n` +
      `>player p1 ${JSON.stringify({ name: 'Red' })}\n` +
      `>player p2 ${JSON.stringify({ name: 'Blue' })}`
    );
  });
}

(async () => {
  const games = [];
  for (let g = 1; g <= 3; g++) games.push(await playGame(g));
  fs.writeFileSync(path.join(outDir, 'series.json'), JSON.stringify({ baseSeed, games }, null, 2));
  const tot = games.reduce((a, x) => a + x.moves.length, 0);
  for (const g of games) console.error(`game${g.game}: ${g.num_turns} turns, ${g.moves.length} moves, winner ${g.winner}`);
  console.error(`total moves across series: ${tot}`);
})();
