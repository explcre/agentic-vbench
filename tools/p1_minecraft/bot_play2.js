// P1 v4: PURPOSEFUL, human-like first-person Minecraft gameplay via mineflayer-pathfinder.
// The bot navigates SMOOTHLY to goals and runs an early-game routine: gather wood from
// trees, mine dirt/grass while exploring, dig stone at a hillside, collect sand, build a
// small shelter, and hunt an animal. Movement is goal-directed (pathfinder), so it looks
// like a real player and produces a VARIED action ledger. Each deliberate action is
// machine ground truth (mineflayer events). prismarine-viewer renders FIRST-PERSON.
const fs = require('fs');
const mineflayer = require('mineflayer');
const { mineflayer: mineflayerViewer } = require('prismarine-viewer');
const { pathfinder, Movements, goals } = require('mineflayer-pathfinder');
const { GoalNear, GoalLookAtBlock, GoalBlock } = goals;

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

const LOGS = ['spruce_log','oak_log','birch_log','jungle_log','acacia_log','dark_oak_log'];
const cat = {
  wood: new Set(LOGS),
  leaves: new Set(['spruce_leaves','oak_leaves','birch_leaves','jungle_leaves']),
  dirt: new Set(['dirt','coarse_dirt','podzol']),
  grass: new Set(['grass_block']),
  stone: new Set(['stone','cobblestone','coal_ore','iron_ore','andesite','diorite','granite']),
  sand: new Set(['sand','gravel','red_sand','sandstone']),
  plant: new Set(['grass','fern','tall_grass','poppy','dandelion','oak_leaves']),
};

bot.once('spawn', async () => {
  const sp = bot.entity.position;
  log('SPAWNED ' + [Math.floor(sp.x),Math.floor(sp.y),Math.floor(sp.z)]);
  mineflayerViewer(bot, { port:3007, firstPerson:true, viewDistance:8 });
  bot.chat('/time set day'); bot.chat('/weather clear');
  for (const it of ['diamond_pickaxe','diamond_axe','diamond_shovel','diamond_sword'])
    bot.chat('/give Builder minecraft:' + it);
  bot.chat('/give Builder minecraft:oak_planks 64');
  for (const ef of ['saturation','regeneration 99999 4','resistance 99999 4','fire_resistance 99999 1','slow_falling 99999 1','night_vision 99999 1'])
    bot.chat('/effect Builder minecraft:' + (ef.includes(' ') ? ef : ef + ' 99999 5') + ' true');
  await sleep(1500);

  const moves = new Movements(bot);
  moves.canDig = true; moves.allow1by1towers = false; moves.allowParkour = true; moves.canOpenDoors = true;
  bot.pathfinder.setMovements(moves);

  const gotoNear = async (pos, range=2, timeout=12000) => {
    const goal = new GoalNear(pos.x, pos.y, pos.z, range);
    const race = Promise.race([
      bot.pathfinder.goto(goal).catch(e => log('goto ' + e.message)),
      sleep(timeout).then(() => 'timeout'),
    ]);
    const r = await race;
    if (r === 'timeout') { try { bot.pathfinder.setGoal(null); } catch (_) {} }
    try { bot.clearControlStates(); } catch (_) {}
    await sleep(200);
  };

  // Navigate to a nearby block of a category and mine `count` of them (real player pace).
  async function gatherCategory(name, count, maxDist=64) {
    const set = cat[name]; let got = 0, misses = 0;
    while (got < count && misses < 4) {
      const b = bot.findBlock({ matching: x => x && set.has(x.name), maxDistance: maxDist, count: 1 });
      if (!b) { misses++; continue; }
      await gotoNear(b.position, 2);
      try {
        const fresh = bot.blockAt(b.position);
        if (fresh && set.has(fresh.name) && bot.canDigBlock(fresh)) {
          const nm = fresh.name; await bot.dig(fresh); rec('mine', nm); got++;
        } else misses++;
      } catch (e) { log('dig '+e.message); misses++; }
    }
  }

  while (!fs.existsSync(GO)) await sleep(200);

  // hunt loop: find the nearest passive animal, walk to it, kill it (varied mobs)
  async function huntOne(maxDist=48) {
    let prey = Object.values(bot.entities).find(e => ['cow','pig','sheep','chicken'].includes(e.name)
                && e.position.distanceTo(bot.entity.position) < maxDist);
    if (!prey) { bot.chat('/summon minecraft:' + ['cow','pig','sheep'][idx % 3] + ' ~ ~ ~5'); await sleep(1500);
      prey = Object.values(bot.entities).find(e => ['cow','pig','sheep','chicken'].includes(e.name)); }
    if (!prey) return;
    const nm = prey.name;
    await gotoNear(prey.position, 2);
    for (let s = 0; s < 22; s++) {
      const e = Object.values(bot.entities).find(x => x.id === prey.id);
      if (!e || !e.isValid) break;
      try { await bot.lookAt(e.position.offset(0,0.5,0), true); bot.attack(e); } catch(_){}
      await sleep(500);
    }
    rec('kill', nm);
  }

  // --- SCENIC purposeful routine: surface only (trees, animals, build, beach sand) ---
  await gatherCategory('wood', 6);
  await gatherCategory('leaves', 5);
  await huntOne();
  await gatherCategory('wood', 6);
  await gatherCategory('leaves', 5);
  await huntOne();
  await gatherCategory('sand', 5, 96);
  await gatherCategory('wood', 6);
  await huntOne();
  await gatherCategory('leaves', 6);

  // build a small shelter: place a few planks around current spot
  try { await bot.equip(bot.inventory.items().find(i=>i.name==='oak_planks'), 'hand'); } catch(_){}
  const base = bot.entity.position.floored();
  for (const [dx,dy,dz] of [[1,0,0],[1,0,1],[0,0,1],[-1,0,1],[-1,0,0]]) {
    try { const ref = bot.blockAt(base.offset(dx, dy-1, dz));
      if (ref && ref.name !== 'air') { await bot.placeBlock(ref, { x:0,y:1,z:0 }); rec('place','oak_planks'); } }
    catch (e) { log('place '+e.message); }
    await sleep(400);
  }
  await gatherCategory('wood', 6);
  await gatherCategory('leaves', 6);
  await huntOne();
  await sleep(1000);
  log('PLAY_DONE ' + events.length);
  fs.writeFileSync(DONE, String(events.length));
});
