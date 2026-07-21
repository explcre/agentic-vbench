// Generate a Gen9 random battle with two random-move agents and capture the full
// protocol log. The log is the machine-truth answer key: every |move|, |switch|,
// |-damage|, |faint|, |turn| line is emitted by the simulator itself.
//
// Usage: node gen_battle.js <seed-int> > battle.log
'use strict';
const Sim = require('pokemon-showdown');
const {RandomPlayerAI} = require('pokemon-showdown/dist/sim/tools/random-player-ai');

const seed = parseInt(process.argv[2] || '1', 10);
const prngSeed = [seed & 0xffff, (seed >> 4) & 0xffff, (seed >> 8) & 0xffff, (seed >> 12) & 0xffff];

const stream = new Sim.BattleStream();
const streams = Sim.getPlayerStreams(stream);
const spec = {formatid: 'gen9randombattle', seed: prngSeed};

const p1 = new RandomPlayerAI(streams.p1, {seed: prngSeed});
const p2 = new RandomPlayerAI(streams.p2, {seed: prngSeed});
p1.start();
p2.start();

(async () => {
  for await (const chunk of streams.omniscient) {
    process.stdout.write(chunk);
  }
})();

void streams.omniscient.write(
  `>start ${JSON.stringify(spec)}\n` +
  `>player p1 ${JSON.stringify({name: 'Red'})}\n` +
  `>player p2 ${JSON.stringify({name: 'Blue'})}`
);
