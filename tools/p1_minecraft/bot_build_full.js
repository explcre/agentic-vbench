// Full scripted Minecraft build/mine session. Waits for a GO file (written by the
// capture orchestrator) so the ground-truth timeline aligns with the video, then
// issues timed /setblock commands building a multi-material structure and mining it.
// Each command is machine ground truth. prismarine-viewer renders for capture.
const fs = require('fs');
const mineflayer = require('mineflayer');
const { mineflayer: mineflayerViewer } = require('prismarine-viewer');

const OUT = process.argv[2];
const GO = process.argv[3];
const DONE = process.argv[4];
const STEP_MS = parseInt(process.argv[5] || '8000', 10);
const CRASH = OUT + '.crash.log';
const log = m => { try { fs.appendFileSync(CRASH, m + '\n'); } catch (_) {} };
process.on('uncaughtException', e => log('UNCAUGHT ' + (e && e.stack || e)));
process.on('unhandledRejection', e => log('REJECT ' + (e && e.stack || e)));

// distinct, visually separable block types
const PAL = ['stone','oak_planks','bricks','gold_block','diamond_block','redstone_block',
             'lapis_block','sand','netherrack','cobblestone','emerald_block'];

const SEED = parseInt(process.argv[6] || '1', 10);
function mulberry32(a){return function(){a|=0;a=a+0x6D2B79F5|0;let t=Math.imul(a^a>>>15,1|a);t=t+Math.imul(t^t>>>7,61|t)^t;return((t^t>>>14)>>>0)/4294967296;};}
const rng = mulberry32(SEED);
const pick = () => PAL[Math.floor(rng()*PAL.length)];

const bot = mineflayer.createBot({ host:'localhost', port:25577, username:'Builder', version:'1.16.5', auth:'offline' });
bot.on('error', e => log('BOT_ERR ' + e.message));
bot.on('kicked', r => log('KICKED ' + JSON.stringify(r)));
bot.on('end', r => log('END ' + r));

function sb(x,y,z,block){ bot.chat(`/setblock ${x} ${y} ${z} minecraft:${block}`); }
const sleep = ms => new Promise(r=>setTimeout(r,ms));

bot.once('spawn', async () => {
  const p = bot.entity.position;
  const bx=Math.floor(p.x), by=Math.floor(p.y), bz=Math.floor(p.z);
  log('SPAWNED ' + [bx,by,bz]);
  mineflayerViewer(bot, { port:3007, firstPerson:false, viewDistance:6 });
  // face the build area
  await sleep(1500);
  // RESET build area to a clean slate (clear any leftover blocks from prior runs)
  const rbx=Math.floor(bot.entity.position.x), rby=Math.floor(bot.entity.position.y), rbz=Math.floor(bot.entity.position.z);
  bot.chat(`/fill ${rbx-2} ${rby-1} ${rbz-6} ${rbx+14} ${rby-1} ${rbz+8} minecraft:grass_block`);
  bot.chat(`/fill ${rbx-2} ${rby} ${rbz-6} ${rbx+14} ${rby+5} ${rbz+8} minecraft:air`);
  await sleep(2500);
  // wait for GO
  while(!fs.existsSync(GO)){ await sleep(200); }
  // wait for GO
  // (GO wait handled above)
  const t0 = Date.now();
  const events = [];
  let idx = 0;
  const sleepUntil = async (ms) => { const d = t0 + ms - Date.now(); if (d>0) await sleep(d); };
  const rec = (action,block,x,y,z) => {
    const t = +(idx*STEP_MS/1000).toFixed(1);   // SCHEDULED time (uniform), not measured
    events.push({t,action,block,x,y,z});
    fs.writeFileSync(OUT, JSON.stringify({n_events:events.length,events},null,2));
  };
  const Y0 = by - 1;               // place at ground level (replace grass) so a flat
  const X0 = bx + 2, Z0 = bz - 4;   // mosaic in front of the bot is fully visible
  const placed = [];
  const put = async (x,z,block) => {
    await sleepUntil(idx*STEP_MS);
    sb(x,Y0,z,block); rec('place',block,x,Y0,z); placed.push({x,y:Y0,z,block}); idx++;
  };
  const brk = async (b) => {
    await sleepUntil(idx*STEP_MS);
    sb(b.x,b.y,b.z,'grass_block'); rec('break',b.block,b.x,b.y,b.z); idx++;
  };
  // 8 x 9 flat mosaic = 72 place events, blocks laid on the ground (no occlusion)
  for(let dz=0; dz<8; dz++) for(let dx=0; dx<9; dx++) await put(X0+dx, Z0+dz, PAL[idx%PAL.length]);
  // break 8 blocks back to grass (spread across the mosaic)
  for(let k=0;k<8;k++) await brk(placed[k*9]);
  await sleepUntil(idx*STEP_MS);
  log('BUILD_DONE ' + events.length);
  fs.writeFileSync(DONE, String(events.length));
});
