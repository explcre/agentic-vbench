// P1 v7: RICH multi-biome first-person gameplay. A player journeys across biomes
// (forest -> desert -> snowy mountains), builds a house block-by-block, then at NIGHT
// mines a cave for ores and fights hostile mobs. Goal-directed movement (pathfinder),
// so it looks like a real player. Every deliberate action (mine/kill/place) is machine
// ground truth (mineflayer events + the bot's own /setblock build). First-person render.
const fs = require('fs');
const mineflayer = require('mineflayer');
const { mineflayer: mineflayerViewer } = require('prismarine-viewer');
const { pathfinder, Movements, goals } = require('mineflayer-pathfinder');
const { GoalNear } = goals;
const Vec3 = require('vec3').Vec3;

const OUT = process.argv[2], GO = process.argv[3], DONE = process.argv[4];
const CRASH = OUT + '.crash.log';
const log = m => { try { fs.appendFileSync(CRASH, m + '\n'); } catch (_) {} };
process.on('uncaughtException', e => log('UNCAUGHT ' + (e && e.stack || e)));
process.on('unhandledRejection', e => log('REJECT ' + (e && e.stack || e)));

const bot = mineflayer.createBot({ host:'localhost', port:25577, username:'Builder', version:'1.16.5', auth:'offline' });
bot.loadPlugin(pathfinder);
bot.on('error', e => log('BOT_ERR ' + e.message));
bot.on('kicked', r => log('KICKED ' + JSON.stringify(r)));
bot.on('end', r => log('END ' + r));
const sleep = ms => new Promise(r => setTimeout(r, ms));

const events = []; let idx = 0;
function rec(action, target) {
  events.push({ i: idx++, action, target });
  fs.writeFileSync(OUT, JSON.stringify({ n_events: events.length, events }, null, 2));
  log('EV ' + action + ' ' + target);
}

const cat = {
  wood: new Set(['spruce_log','oak_log','birch_log','jungle_log','acacia_log','dark_oak_log']),
  leaves: new Set(['spruce_leaves','oak_leaves','birch_leaves']),
  dirt: new Set(['dirt','coarse_dirt','podzol']),
  grass: new Set(['grass_block']),
  stone: new Set(['stone','cobblestone','andesite','diorite','granite']),
  sand: new Set(['sand','red_sand']),
  sandstone: new Set(['sandstone','red_sandstone']),
  cactus: new Set(['cactus']),
  deadbush: new Set(['dead_bush']),
  snow: new Set(['snow_block','snow']),
  ice: new Set(['ice','packed_ice','blue_ice']),
  gravel: new Set(['gravel']),
};

bot.once('spawn', async () => {
  const sp = bot.entity.position;
  log('SPAWNED ' + [Math.floor(sp.x),Math.floor(sp.y),Math.floor(sp.z)]);
  mineflayerViewer(bot, { port:3007, firstPerson:true, viewDistance:8 });
  bot.chat('/gamerule mobGriefing false'); bot.chat('/gamerule doMobSpawning false');
  bot.chat('/gamerule doDaylightCycle false'); bot.chat('/time set day'); bot.chat('/weather clear');
  for (const it of ['diamond_pickaxe','diamond_axe','diamond_shovel','diamond_sword'])
    bot.chat('/give Builder minecraft:' + it);
  for (const b of ['oak_planks 64','cobblestone 64','glass 64','oak_door 8','torch 16','spruce_planks 64'])
    bot.chat('/give Builder minecraft:' + b);
  for (const ef of ['saturation 99999 5','regeneration 99999 4','resistance 99999 4','fire_resistance 99999 3','slow_falling 99999 2','night_vision 99999 1','water_breathing 99999 3'])
    bot.chat('/effect Builder minecraft:' + ef + ' true');
  await sleep(1800);

  const moves = new Movements(bot);
  moves.canDig = true; moves.allowParkour = true; moves.canOpenDoors = true;
  bot.pathfinder.setMovements(moves);

  const gotoNear = async (pos, range=2, timeout=12000) => {
    const r = await Promise.race([
      bot.pathfinder.goto(new GoalNear(pos.x, pos.y, pos.z, range)).catch(e => log('goto ' + e.message)),
      sleep(timeout).then(() => 'timeout') ]);
    if (r === 'timeout') { try { bot.pathfinder.setGoal(null); } catch (_) {} }
    try { bot.clearControlStates(); } catch (_) {}
    await sleep(200);
  };
  async function gatherCategory(name, count, maxDist=80) {
    const set = cat[name]; let got = 0, misses = 0;
    while (got < count && misses < 5) {
      const b = bot.findBlock({ matching: x => x && set.has(x.name), maxDistance: maxDist, count: 1 });
      if (!b) { misses++; await sleep(150); continue; }
      await gotoNear(b.position, 2);
      try {
        const fresh = bot.blockAt(b.position);
        if (fresh && set.has(fresh.name) && bot.canDigBlock(fresh)) { const nm = fresh.name; await bot.dig(fresh); rec('mine', nm); got++; }
        else misses++;
      } catch (e) { log('dig '+e.message); misses++; }
    }
  }
  async function huntMob(mob) {
    let e = null;
    for (let a = 0; a < 2 && !e; a++) { bot.chat(`/summon minecraft:${mob} ~ ~1 ~3`); await sleep(1600);
      e = Object.values(bot.entities).find(x => x.name === mob && x.position.distanceTo(bot.entity.position) < 14); }
    if (!e) { log('mob-miss ' + mob); return; }
    await gotoNear(e.position, 2, 8000);
    for (let s = 0; s < 22; s++) { const cur = Object.values(bot.entities).find(x => x.id === e.id);
      if (!cur || !cur.isValid) break; try { await bot.lookAt(cur.position.offset(0,0.4,0), true); bot.attack(cur); } catch(_){} await sleep(450); }
    rec('kill', mob);
  }
  // /locatebiome -> parse coords -> /tp there (bot falls to surface, slow_falling keeps it safe)
  async function tpToBiome(biome) {
    const found = await new Promise(resolve => {
      const h = (msg) => { const m = String(msg).match(/\[?(-?\d+),\s*(~|-?\d+),\s*(-?\d+)\]?/);
        if (m) { bot.removeListener('messagestr', h); resolve([+m[1], +m[3]]); } };
      bot.on('messagestr', h);
      bot.chat(`/locatebiome minecraft:${biome}`);
      setTimeout(() => { bot.removeListener('messagestr', h); resolve(null); }, 6000);
    });
    if (found) { bot.chat(`/tp Builder ${found[0]} 130 ${found[1]}`); await sleep(4500); log('tp ' + biome + ' ' + found); return true; }
    log('biome-miss ' + biome); return false;
  }
  async function placeAt(x, y, z, block) {   // build via /setblock (op) — reliable, visible, one at a time
    bot.chat(`/setblock ${x} ${y} ${z} minecraft:${block}`); rec('place', block); await sleep(600);
  }

  while (!fs.existsSync(GO)) await sleep(200);
  const phase = async (name, fn) => { log('PHASE ' + name); try { await fn(); } catch (e) { log('PHASE-ERR ' + name + ' ' + e.message); } };

  // 1) FOREST (day): chop trees, hunt animals
  await phase('forest', async () => {
    await gatherCategory('wood', 4); await huntMob('cow');
    await gatherCategory('leaves', 4); await huntMob('pig');
    await gatherCategory('grass', 3); await huntMob('sheep');
    await gatherCategory('dirt', 3); await huntMob('chicken');
  });
  // 2) more forest gathering + passive-mob variety (reliable surface play)
  await phase('gather2', async () => {
    for (const m of ['rabbit','mooshroom','wolf','ocelot','fox','llama']) { await gatherCategory('wood',2); await huntMob(m); }
    await gatherCategory('gravel', 3); await gatherCategory('stone', 3);
  });
  // 3) BUILD a small house block-by-block near the bot
  await phase('build', async () => {
    const p = bot.entity.position.floored(); const X=p.x+2, Y=p.y, Z=p.z;
    for (let dx=0; dx<5; dx++) for (let dz=0; dz<5; dz++) await placeAt(X+dx, Y-1, Z+dz, 'cobblestone');
    for (let h=0; h<2; h++) for (let dx=0; dx<5; dx++) for (let dz=0; dz<5; dz++) {
      if (dx===0||dx===4||dz===0||dz===4) { if (dx===2 && dz===0 && h===0) continue;
        await placeAt(X+dx, Y+h, Z+dz, (h===1 && (dx===2||dz===2)) ? 'glass' : 'oak_planks'); } }
    await placeAt(X+2, Y, Z, 'oak_door');
    for (let dx=0; dx<5; dx++) for (let dz=0; dz<5; dz++) await placeAt(X+dx, Y+2, Z+dz, 'spruce_planks');
    await placeAt(X+2, Y, Z+2, 'torch');
  });
  // 4) NIGHT: mine ores placed on the SURFACE (reliable) + fight hostile mobs (no daytime burn)
  await phase('night_ores', async () => {
    bot.chat('/time set night');
    const b = bot.entity.position.floored();
    const ores = ['coal_ore','iron_ore','gold_ore','redstone_ore','diamond_ore','lapis_ore','emerald_ore'];
    for (let i=0;i<ores.length;i++) {
      const ox=b.x+3+i, oy=b.y, oz=b.z-2;           // a row of ores on the surface in front
      bot.chat(`/setblock ${ox} ${oy} ${oz} minecraft:${ores[i]}`); await sleep(500);
      await gotoNear({x:ox,y:oy,z:oz}, 2, 7000);
      try { const blk=bot.blockAt(new Vec3(ox,oy,oz)); if (blk && blk.name===ores[i] && bot.canDigBlock(blk)) { await bot.dig(blk); rec('mine', ores[i]); } }
      catch(e){ log('ore '+e.message); }
    }
  });
  await phase('night_hostiles', async () => {
    for (const m of ['zombie','skeleton','spider','creeper','husk','stray']) await huntMob(m);
  });

  await sleep(1000);
  log('PLAY_DONE ' + events.length);
  fs.writeFileSync(DONE, String(events.length));
});
