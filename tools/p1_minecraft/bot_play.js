// P1 v3: real first-person gameplay in a GENERATED world. Bot walks, looks around,
// mines real nearby blocks (findBlock + dig, camera turns to each), collects drops,
// fights a summoned mob. Each ACTION = machine ground truth. prismarine-viewer renders
// the FIRST-PERSON view for capture.
const fs = require('fs');
const mineflayer = require('mineflayer');
const { mineflayer: mineflayerViewer } = require('prismarine-viewer');

const OUT = process.argv[2], GO = process.argv[3], DONE = process.argv[4];
const STEP = parseInt(process.argv[5] || '6000', 10);
const CRASH = OUT + '.crash.log';
const log = m => { try { fs.appendFileSync(CRASH, m + '\n'); } catch (_) {} };
process.on('uncaughtException', e => log('UNCAUGHT ' + (e && e.stack || e)));
process.on('unhandledRejection', e => log('REJECT ' + (e && e.stack || e)));

const DIG = new Set(['spruce_log','oak_log','birch_log','jungle_log','acacia_log','dark_oak_log',
  'spruce_leaves','oak_leaves','birch_leaves','dirt','coarse_dirt','podzol','grass_block',
  'stone','cobblestone','gravel','sand','grass','fern','tall_grass','mossy_cobblestone']);

const bot = mineflayer.createBot({ host:'localhost', port:25577, username:'Builder', version:'1.16.5', auth:'offline' });
bot.on('error', e => log('BOT_ERR ' + e.message));
bot.on('kicked', r => log('KICKED ' + JSON.stringify(r)));
bot.on('end', r => log('END ' + r));
const sleep = ms => new Promise(r => setTimeout(r, ms));

const events = []; let idx = 0;
function rec(event, target) {
  events.push({ i: idx++, event, target });
  fs.writeFileSync(OUT, JSON.stringify({ n_events: events.length, events }, null, 2));
  log('EV ' + event + ' ' + target);
}
bot.on('playerCollect', (collector, collected) => {
  if (collector.username === bot.username) {
    try { const it = collected.getDroppedItem && collected.getDroppedItem();
      if (it && it.name) rec('collect', it.name); } catch (_) {}
  }
});

bot.once('spawn', async () => {
  const p = bot.entity.position;
  log('SPAWNED ' + [Math.floor(p.x),Math.floor(p.y),Math.floor(p.z)]);
  mineflayerViewer(bot, { port:3007, firstPerson:true, viewDistance:6 });
  bot.chat('/time set day'); bot.chat('/weather clear');
  bot.chat('/give Builder minecraft:diamond_pickaxe'); bot.chat('/give Builder minecraft:diamond_axe');
  bot.chat('/give Builder minecraft:diamond_sword');
  bot.chat('/effect Builder minecraft:saturation 99999 5 true');
  bot.chat('/effect Builder minecraft:regeneration 99999 4 true');
  bot.chat('/effect Builder minecraft:resistance 99999 4 true');
  bot.chat('/effect Builder minecraft:fire_resistance 99999 1 true');
  bot.chat('/effect Builder minecraft:slow_falling 99999 1 true');
  bot.chat('/effect Builder minecraft:water_breathing 99999 1 true');
  bot.chat('/effect Builder minecraft:night_vision 99999 1 true');
  await sleep(1500);
  try { await bot.equip(bot.inventory.items().find(i=>i.name==='diamond_pickaxe'), 'hand'); } catch(_){}
  while (!fs.existsSync(GO)) await sleep(200);

  const t0 = Date.now();
  const at = async k => { const d = t0 + k*STEP - Date.now(); if (d>0) await sleep(d); };
  let k = 0;
  const CATS = [
    ['spruce_log','oak_log','birch_log','jungle_log','acacia_log','dark_oak_log'],
    ['spruce_leaves','oak_leaves','birch_leaves','jungle_leaves'],
    ['dirt','coarse_dirt','podzol'],
    ['grass_block'],
    ['sand','gravel'],
    ['stone','cobblestone'],
  ];
  let catIdx = 0;
  async function mineNearby() {
    for (let tries = 0; tries < CATS.length; tries++) {
      const set = new Set(CATS[(catIdx + tries) % CATS.length]);
      const target = bot.findBlock({ matching: b => b && set.has(b.name), maxDistance: 5, count: 1 });
      if (target && target.position.y >= Math.floor(bot.entity.position.y) - 2) {  // stay near surface
        catIdx = (catIdx + tries + 1) % CATS.length;
        try { await bot.dig(target); rec('mine', target.name); return true; }
        catch (e) { log('dig-fail ' + e.message); }
      }
    }
    return false;
  }
  for (const yaw of [0, Math.PI/2, Math.PI, -Math.PI/2]) { await at(k++); await bot.look(yaw, -0.15, true); await sleep(500); }
  for (let s = 0; s < 46; s++) {
    await at(k++);
    await bot.look(bot.entity.yaw + (Math.random()-0.5), 0.2, true);
    bot.setControlState('forward', true); await sleep(900); bot.setControlState('forward', false);
    await mineNearby();
  }
  await at(k++);
  bot.chat('/summon minecraft:pig ~ ~ ~3');
  await sleep(1500);
  for (let s = 0; s < 20; s++) {
    const mob = Object.values(bot.entities).find(e => (e.name==='pig') && e.position.distanceTo(bot.entity.position) < 7);
    if (!mob) break;
    try { await bot.lookAt(mob.position.offset(0,0.4,0), true); bot.attack(mob); } catch(_){}
    await sleep(600);
  }
  rec('mob_kill', 'pig');
  for (let s = 0; s < 44; s++) {
    await at(k++);
    await bot.look(bot.entity.yaw + (Math.random()-0.5), 0.25, true);
    bot.setControlState('forward', true); await sleep(800); bot.setControlState('forward', false);
    await mineNearby();
  }
  await at(k++);
  log('PLAY_DONE ' + events.length);
  fs.writeFileSync(DONE, String(events.length));
});
