// ── Primordial Soup WASM Core ──────────────────────────────────────
// BF-variant cellular automaton compiled to WebAssembly via AssemblyScript
//
// Language versions (cumulative):
//   v1 CLASSIC  — < > { } - + . , [ ]
//   v2 SPATIAL  — adds ^ v ( ) : heads move up/down a row (tape as 8-wide grid)
//   v3 EXTENDED — adds 0 @ ! ? : zero cell, swap heads, swap values, random byte

// ── v1 opcodes ──
const LT:    u8 = 60;   // <  head0 left
const GT:    u8 = 62;   // >  head0 right
const LB:    u8 = 123;  // {  head1 left
const RB:    u8 = 125;  // }  head1 right
const MINUS: u8 = 45;   // -  dec at head0
const PLUS:  u8 = 43;   // +  inc at head0
const DOT:   u8 = 46;   // .  copy head0 -> head1
const COMMA: u8 = 44;   // ,  copy head1 -> head0
const LBRACK:u8 = 91;   // [  loop start (jump fwd if cell at head0 == 0)
const RBRACK:u8 = 93;   // ]  loop end   (jump back if cell at head0 != 0)

// ── v2 opcodes (spatial: tape treated as rows of 8, matching render tiles) ──
const H0UP:  u8 = 94;   // ^  head0 up one row (-8, wrap)
const H0DN:  u8 = 118;  // v  head0 down one row (+8, wrap)
const H1UP:  u8 = 40;   // (  head1 up one row
const H1DN:  u8 = 41;   // )  head1 down one row

// ── v3 opcodes (extended) ──
const ZERO:  u8 = 48;   // 0  zero the byte at head0
const SWAPH: u8 = 64;   // @  swap head0 and head1 positions
const SWAPV: u8 = 33;   // !  swap the bytes at head0 and head1
const RAND:  u8 = 63;   // ?  write a random byte at head0

const ROW: i32 = 8;     // row width for spatial moves (one render-tile row)

// ── Simulation state ──
let gridWidth: i32 = 0;
let gridHeight: i32 = 0;
let tapeSize: i32 = 0;
let numPrograms: i32 = 0;
let maxIter: i32 = 8192;
let langVersion: i32 = 1;

// ── Ecology options (all default to classic behaviour) ──
let couplingMode: i32 = 0;     // 0 = 5×5 random, 1 = von Neumann 4-neighbour, 2 = directional sweep
let sweepCounter: i32 = 0;     // drives the alternating axis in directional mode
let substrateOn: i32 = 0;      // 0 = off (uniform mutation), 1 = field modulates mutation
let substrateStrength: i32 = 60; // 0..100, how hard the field bends the local mutation rate

// Flat buffers (offsets into WASM linear memory)
let programsPtr: usize = 0;
let neighborsPtr: usize = 0;
let nCountsPtr: usize = 0;
let orderPtr: usize = 0;
let proposalsPtr: usize = 0;
let pairsPtr: usize = 0;
let takenPtr: usize = 0;
let tapePtr: usize = 0;
let pixelsPtr: usize = 0;
let colorLutPtr: usize = 0;
let histogramPtr: usize = 0;
let substratePtr: usize = 0;

// xorshift128+ RNG state
let rngS0: u64 = 0;
let rngS1: u64 = 0;

function rngNext(): u64 {
  let s1 = rngS0;
  let s0 = rngS1;
  rngS0 = s0;
  s1 ^= s1 << 23;
  s1 ^= s1 >> 17;
  s1 ^= s0;
  s1 ^= s0 >> 26;
  rngS1 = s1;
  return rngS0 + rngS1;
}

function rngNextU32(): u32 {
  return <u32>(rngNext() >> 32);
}

function rngBounded(bound: u32): u32 {
  if (bound <= 1) return 0;
  let r = rngNextU32();
  let threshold = (~bound + 1) % bound;
  while (r < threshold) {
    r = rngNextU32();
  }
  return r % bound;
}

function splitmix64(state: u64): u64 {
  state += 0x9E3779B97F4A7C15;
  state = (state ^ (state >> 30)) * 0xBF58476D1CE4E5B9;
  state = (state ^ (state >> 27)) * 0x94D049BB133111EB;
  return state ^ (state >> 31);
}

@inline
function setColor(base: usize, idx: i32, r: u8, g: u8, b: u8): void {
  let off = base + <usize>(idx * 4);
  store<u8>(off, r);
  store<u8>(off + 1, g);
  store<u8>(off + 2, b);
  store<u8>(off + 3, 255);
}

export function setLangVersion(v: i32): void {
  if (v < 1) v = 1;
  if (v > 3) v = 3;
  langVersion = v;
}

export function getLangVersion(): i32 {
  return langVersion;
}

export function init(w: i32, h: i32, ts: i32, seed: u64): void {
  gridWidth = w;
  gridHeight = h;
  tapeSize = ts;
  numPrograms = w * h;

  rngS0 = splitmix64(seed);
  rngS1 = splitmix64(rngS0);

  let offset: usize = __heap_base;

  programsPtr = offset;
  offset += <usize>(numPrograms * tapeSize);

  neighborsPtr = offset;
  offset += <usize>(numPrograms * 24 * 4);

  nCountsPtr = offset;
  offset += <usize>(numPrograms * 4);

  orderPtr = offset;
  offset += <usize>(numPrograms * 4);

  proposalsPtr = offset;
  offset += <usize>(numPrograms * 4);

  pairsPtr = offset;
  offset += <usize>(numPrograms * 2 * 4);

  takenPtr = offset;
  offset += <usize>(numPrograms);

  tapePtr = offset;
  offset += <usize>(tapeSize * 2);

  pixelsPtr = offset;
  offset += <usize>(gridWidth * 8 * gridHeight * 8 * 4);

  colorLutPtr = offset;
  offset += 256 * 4;

  histogramPtr = offset;
  offset += 256 * 4;

  substratePtr = offset;
  offset += <usize>numPrograms;

  // Grow memory if needed
  let pages = <i32>((offset + 65535) >> 16);
  let currentPages = memory.size();
  if (pages > currentPages) {
    memory.grow(pages - currentPages);
  }

  // Initialize programs with random bytes
  for (let i: i32 = 0; i < numPrograms * tapeSize; i++) {
    store<u8>(programsPtr + <usize>i, <u8>(rngNextU32() & 0xFF));
  }

  buildNeighborhood();
  generateSubstrate(seed);

  // Build color LUT
  for (let i: i32 = 0; i < 256; i++) {
    setColor(colorLutPtr, i, 20, 20, 20);
  }
  // v1
  setColor(colorLutPtr, LT,     239, 71,  111);
  setColor(colorLutPtr, GT,     255, 209, 102);
  setColor(colorLutPtr, LB,     6,   214, 160);
  setColor(colorLutPtr, RB,     17,  138, 178);
  setColor(colorLutPtr, MINUS,  255, 127, 80);
  setColor(colorLutPtr, PLUS,   131, 56,  236);
  setColor(colorLutPtr, DOT,    58,  134, 255);
  setColor(colorLutPtr, COMMA,  255, 190, 11);
  setColor(colorLutPtr, LBRACK, 139, 201, 38);
  setColor(colorLutPtr, RBRACK, 255, 89,  94);
  // v2
  setColor(colorLutPtr, H0UP,   0,   245, 212);
  setColor(colorLutPtr, H0DN,   241, 91,  181);
  setColor(colorLutPtr, H1UP,   155, 93,  229);
  setColor(colorLutPtr, H1DN,   0,   187, 249);
  // v3
  setColor(colorLutPtr, ZERO,   235, 235, 235);
  setColor(colorLutPtr, SWAPH,  251, 86,  7);
  setColor(colorLutPtr, SWAPV,  255, 0,   110);
  setColor(colorLutPtr, RAND,   202, 255, 191);
}

export function getPixelsPtr(): usize { return pixelsPtr; }
export function getPixelsLen(): i32 { return gridWidth * 8 * gridHeight * 8 * 4; }
export function getProgramsPtr(): usize { return programsPtr; }

// ── Neighbourhood / coupling ──
// Rebuilds the per-cell neighbour table for the current coupling mode.
// Mode 0 stores the 5×5-minus-self set; modes 1 and 2 store the 4 orthogonal
// neighbours (mode 2 — directional sweep — picks its partner directly in
// generateProposals and doesn't read the table, but we keep it populated).
function buildNeighborhood(): void {
  if (couplingMode == 0) {
    for (let x: i32 = 0; x < gridWidth; x++) {
      let xLo = x - 2; if (xLo < 0) xLo = 0;
      let xHi = x + 3; if (xHi > gridWidth) xHi = gridWidth;
      for (let y: i32 = 0; y < gridHeight; y++) {
        let yLo = y - 2; if (yLo < 0) yLo = 0;
        let yHi = y + 3; if (yHi > gridHeight) yHi = gridHeight;
        let idx = x * gridHeight + y;
        let count: i32 = 0;
        for (let nx = xLo; nx < xHi; nx++) {
          let base = nx * gridHeight;
          for (let ny = yLo; ny < yHi; ny++) {
            if (nx == x && ny == y) continue;
            store<i32>(neighborsPtr + <usize>((idx * 24 + count) * 4), base + ny);
            count++;
          }
        }
        store<i32>(nCountsPtr + <usize>(idx * 4), count);
      }
    }
  } else {
    for (let x: i32 = 0; x < gridWidth; x++) {
      for (let y: i32 = 0; y < gridHeight; y++) {
        let idx = x * gridHeight + y;
        let count: i32 = 0;
        if (x - 1 >= 0)         { store<i32>(neighborsPtr + <usize>((idx * 24 + count) * 4), (x - 1) * gridHeight + y); count++; }
        if (x + 1 < gridWidth)  { store<i32>(neighborsPtr + <usize>((idx * 24 + count) * 4), (x + 1) * gridHeight + y); count++; }
        if (y - 1 >= 0)         { store<i32>(neighborsPtr + <usize>((idx * 24 + count) * 4), x * gridHeight + (y - 1)); count++; }
        if (y + 1 < gridHeight) { store<i32>(neighborsPtr + <usize>((idx * 24 + count) * 4), x * gridHeight + (y + 1)); count++; }
        store<i32>(nCountsPtr + <usize>(idx * 4), count);
      }
    }
  }
}

// ── Substrate field ──
// A smooth static terrain in [0,255] per cell, built from a couple of sinusoid
// octaves. Uses its own splitmix-derived phases so it never disturbs the sim RNG.
function generateSubstrate(seed: u64): void {
  let st = splitmix64(seed ^ 0xD1B54A32D192ED03);
  let fx1 = <f64>(1 + <i32>(st % 3)); st = splitmix64(st);
  let fy1 = <f64>(1 + <i32>(st % 3)); st = splitmix64(st);
  let px1 = <f64>(<i32>(st % 6283)) / 1000.0; st = splitmix64(st);
  let py1 = <f64>(<i32>(st % 6283)) / 1000.0; st = splitmix64(st);
  let fx2 = <f64>(2 + <i32>(st % 4)); st = splitmix64(st);
  let fy2 = <f64>(2 + <i32>(st % 4)); st = splitmix64(st);
  let px2 = <f64>(<i32>(st % 6283)) / 1000.0; st = splitmix64(st);
  let py2 = <f64>(<i32>(st % 6283)) / 1000.0;

  const TAU = 6.283185307179586;
  let dx = gridWidth  > 1 ? <f64>(gridWidth  - 1) : 1.0;
  let dy = gridHeight > 1 ? <f64>(gridHeight - 1) : 1.0;

  for (let x: i32 = 0; x < gridWidth; x++) {
    let nx = <f64>x / dx;
    for (let y: i32 = 0; y < gridHeight; y++) {
      let ny = <f64>y / dy;
      let v = Math.sin(nx * TAU * fx1 + px1) * Math.cos(ny * TAU * fy1 + py1);
      v += 0.5 * Math.sin(nx * TAU * fx2 + px2) * Math.cos(ny * TAU * fy2 + py2);
      let nv = (v / 1.5 + 1.0) * 0.5;   // → ~[0,1]
      if (nv < 0.0) nv = 0.0;
      if (nv > 1.0) nv = 1.0;
      store<u8>(substratePtr + <usize>(x * gridHeight + y), <u8>(nv * 255.0));
    }
  }
}

export function setCoupling(mode: i32): void {
  if (mode < 0) mode = 0;
  if (mode > 2) mode = 2;
  couplingMode = mode;
  buildNeighborhood();
}
export function getCoupling(): i32 { return couplingMode; }

export function setSubstrate(on: i32, strength: i32): void {
  substrateOn = on != 0 ? 1 : 0;
  if (strength < 0) strength = 0;
  if (strength > 100) strength = 100;
  substrateStrength = strength;
}
export function regenSubstrate(seed: u64): void { generateSubstrate(seed); }
export function getSubstratePtr(): usize { return substratePtr; }
export function getSubstrateLen(): i32 { return numPrograms; }

// ── BF tape interpreter ──
function runTape(tapeBase: usize, sz: i32): void {
  let pc: i32 = 0;
  let head0: i32 = 0;
  let head1: i32 = 0;
  let lv = langVersion;

  for (let iter: i32 = 0; iter < maxIter; iter++) {
    if (<u32>pc >= <u32>sz) break;

    let opcode = load<u8>(tapeBase + <usize>pc);

    if (opcode == LT) {
      head0--;
      if (head0 < 0) head0 += sz;
    } else if (opcode == GT) {
      head0++;
      if (head0 >= sz) head0 -= sz;
    } else if (opcode == LB) {
      head1--;
      if (head1 < 0) head1 += sz;
    } else if (opcode == RB) {
      head1++;
      if (head1 >= sz) head1 -= sz;
    } else if (opcode == MINUS) {
      let addr = tapeBase + <usize>head0;
      store<u8>(addr, load<u8>(addr) - 1);
    } else if (opcode == PLUS) {
      let addr = tapeBase + <usize>head0;
      store<u8>(addr, load<u8>(addr) + 1);
    } else if (opcode == DOT) {
      store<u8>(tapeBase + <usize>head1, load<u8>(tapeBase + <usize>head0));
    } else if (opcode == COMMA) {
      store<u8>(tapeBase + <usize>head0, load<u8>(tapeBase + <usize>head1));
    } else if (opcode == LBRACK) {
      if (load<u8>(tapeBase + <usize>head0) == 0) {
        let depth: i32 = 1;
        pc++;
        while (pc < sz && depth > 0) {
          let c = load<u8>(tapeBase + <usize>pc);
          if (c == LBRACK) depth++;
          else if (c == RBRACK) depth--;
          if (depth > 0) pc++;
        }
        if (depth != 0) return;
      }
    } else if (opcode == RBRACK) {
      if (load<u8>(tapeBase + <usize>head0) != 0) {
        let depth: i32 = 1;
        pc--;
        while (pc >= 0 && depth > 0) {
          let c = load<u8>(tapeBase + <usize>pc);
          if (c == RBRACK) depth++;
          else if (c == LBRACK) depth--;
          if (depth > 0) pc--;
        }
        if (depth != 0) return;
      }
    } else if (lv >= 2) {
      if (opcode == H0UP) {
        head0 -= ROW;
        if (head0 < 0) head0 += sz;
      } else if (opcode == H0DN) {
        head0 += ROW;
        if (head0 >= sz) head0 -= sz;
      } else if (opcode == H1UP) {
        head1 -= ROW;
        if (head1 < 0) head1 += sz;
      } else if (opcode == H1DN) {
        head1 += ROW;
        if (head1 >= sz) head1 -= sz;
      } else if (lv >= 3) {
        if (opcode == ZERO) {
          store<u8>(tapeBase + <usize>head0, 0);
        } else if (opcode == SWAPH) {
          let t = head0;
          head0 = head1;
          head1 = t;
        } else if (opcode == SWAPV) {
          let a = tapeBase + <usize>head0;
          let b = tapeBase + <usize>head1;
          let va = load<u8>(a);
          store<u8>(a, load<u8>(b));
          store<u8>(b, va);
        } else if (opcode == RAND) {
          store<u8>(tapeBase + <usize>head0, <u8>(rngNextU32() & 0xFF));
        }
      }
    }

    pc++;
  }
}

function shuffleOrder(): void {
  for (let i: i32 = 0; i < numPrograms; i++) {
    store<i32>(orderPtr + <usize>(i * 4), i);
  }
  for (let i: i32 = numPrograms - 1; i > 0; i--) {
    let j = <i32>rngBounded(<u32>(i + 1));
    let addrI = orderPtr + <usize>(i * 4);
    let addrJ = orderPtr + <usize>(j * 4);
    let ai = load<i32>(addrI);
    let aj = load<i32>(addrJ);
    store<i32>(addrI, aj);
    store<i32>(addrJ, ai);
  }
}

function generateProposals(): void {
  if (couplingMode == 2) {
    // Directional sweep: alternate the pairing axis each epoch. Every cell
    // proposes the neighbour one step along the current axis (±1, random side).
    let axis = sweepCounter & 1;   // 0 = horizontal, 1 = vertical
    for (let i: i32 = 0; i < numPrograms; i++) {
      let x = i / gridHeight;
      let y = i % gridHeight;
      let d = rngBounded(2) == 0 ? -1 : 1;
      let nx = x, ny = y;
      if (axis == 0) nx += d; else ny += d;
      if (nx < 0 || nx >= gridWidth || ny < 0 || ny >= gridHeight) {
        store<i32>(proposalsPtr + <usize>(i * 4), -1);
      } else {
        store<i32>(proposalsPtr + <usize>(i * 4), nx * gridHeight + ny);
      }
    }
    return;
  }

  for (let i: i32 = 0; i < numPrograms; i++) {
    let nc = load<i32>(nCountsPtr + <usize>(i * 4));
    if (nc > 0) {
      let choice = <i32>rngBounded(<u32>nc);
      store<i32>(proposalsPtr + <usize>(i * 4),
        load<i32>(neighborsPtr + <usize>((i * 24 + choice) * 4)));
    } else {
      store<i32>(proposalsPtr + <usize>(i * 4), -1);
    }
  }
}

function selectPairs(): i32 {
  memory.fill(takenPtr, 0, <usize>numPrograms);
  let pairCount: i32 = 0;

  for (let i: i32 = 0; i < numPrograms; i++) {
    let p = load<i32>(orderPtr + <usize>(i * 4));
    let n = load<i32>(proposalsPtr + <usize>(p * 4));
    if (n < 0) continue;
    if (load<u8>(takenPtr + <usize>p) != 0) continue;
    if (load<u8>(takenPtr + <usize>n) != 0) continue;

    store<u8>(takenPtr + <usize>p, 1);
    store<u8>(takenPtr + <usize>n, 1);
    store<i32>(pairsPtr + <usize>(pairCount * 8), p);
    store<i32>(pairsPtr + <usize>(pairCount * 8 + 4), n);
    pairCount++;
  }
  return pairCount;
}

function runPairs(pairCount: i32): void {
  let concatSize = tapeSize * 2;
  for (let pi: i32 = 0; pi < pairCount; pi++) {
    let idxA = load<i32>(pairsPtr + <usize>(pi * 8));
    let idxB = load<i32>(pairsPtr + <usize>(pi * 8 + 4));
    let srcA = programsPtr + <usize>(idxA * tapeSize);
    let srcB = programsPtr + <usize>(idxB * tapeSize);

    memory.copy(tapePtr, srcA, <usize>tapeSize);
    memory.copy(tapePtr + <usize>tapeSize, srcB, <usize>tapeSize);
    runTape(tapePtr, concatSize);
    memory.copy(srcA, tapePtr, <usize>tapeSize);
    memory.copy(srcB, tapePtr + <usize>tapeSize, <usize>tapeSize);
  }
}

function applyMutation(rateNum: i32, rateDen: i32): void {
  if (rateNum <= 0) return;

  if (substrateOn == 0) {
    let total = numPrograms * tapeSize;
    for (let i: i32 = 0; i < total; i++) {
      if (<i32>rngBounded(<u32>rateDen) < rateNum) {
        store<u8>(programsPtr + <usize>i, <u8>(rngNextU32() & 0xFF));
      }
    }
    return;
  }

  // Field-modulated: each cell's mutation rate is scaled by its substrate value.
  // strength 0 → no effect; strength 100 → field maps to 0× (refuge) … 2× (barrier).
  let s = substrateStrength;
  for (let p: i32 = 0; p < numPrograms; p++) {
    let fv = <i32>load<u8>(substratePtr + <usize>p);                 // 0..255
    let m = (100 - s) + (fv * 200 / 255) * s / 100;                  // ~0..200 (percent)
    let eff = rateNum * m / 100;
    if (eff <= 0) continue;
    let base = programsPtr + <usize>(p * tapeSize);
    for (let j: i32 = 0; j < tapeSize; j++) {
      if (<i32>rngBounded(<u32>rateDen) < eff) {
        store<u8>(base + <usize>j, <u8>(rngNextU32() & 0xFF));
      }
    }
  }
}

function isOpcode(v: u8): bool {
  if (v == LT || v == GT || v == LB || v == RB ||
      v == MINUS || v == PLUS || v == DOT || v == COMMA ||
      v == LBRACK || v == RBRACK) return true;
  if (langVersion >= 2 &&
      (v == H0UP || v == H0DN || v == H1UP || v == H1DN)) return true;
  if (langVersion >= 3 &&
      (v == ZERO || v == SWAPH || v == SWAPV || v == RAND)) return true;
  return false;
}

@inline
function normalizeCell(val: u8): u8 {
  return isOpcode(val) ? val : 255;
}

export function renderPixels(): void {
  let pixW = gridWidth * 8;
  for (let gx: i32 = 0; gx < gridWidth; gx++) {
    for (let gy: i32 = 0; gy < gridHeight; gy++) {
      let progBase = programsPtr + <usize>((gx * gridHeight + gy) * tapeSize);
      for (let ty: i32 = 0; ty < 8; ty++) {
        for (let tx: i32 = 0; tx < 8; tx++) {
          let normVal = normalizeCell(load<u8>(progBase + <usize>(ty * 8 + tx)));
          let px = gx * 8 + tx;
          let py = gy * 8 + ty;
          let pixOff = pixelsPtr + <usize>((py * pixW + px) * 4);
          let lutOff = colorLutPtr + <usize>(<i32>normVal * 4);
          store<u32>(pixOff, load<u32>(lutOff));
        }
      }
    }
  }
}

export function step(mutRateNum: i32, mutRateDen: i32): void {
  shuffleOrder();
  generateProposals();
  let pairCount = selectPairs();
  runPairs(pairCount);
  applyMutation(mutRateNum, mutRateDen);
  sweepCounter++;
}

export function opcodeCount(): i32 {
  let count: i32 = 0;
  let total = numPrograms * tapeSize;
  for (let i: i32 = 0; i < total; i++) {
    if (isOpcode(load<u8>(programsPtr + <usize>i))) count++;
  }
  return count;
}

export function totalCells(): i32 {
  return numPrograms * tapeSize;
}

export function getHistogramPtr(): usize { return histogramPtr; }

// Fill the histogram buffer with the per-byte-value counts (256 i32 slots).
// JS reads out whichever opcode rows it wants to plot.
export function computeHistogram(): void {
  memory.fill(histogramPtr, 0, 256 * 4);
  let total = numPrograms * tapeSize;
  for (let i: i32 = 0; i < total; i++) {
    let v = <i32>load<u8>(programsPtr + <usize>i);
    let slot = histogramPtr + <usize>(v * 4);
    store<i32>(slot, load<i32>(slot) + 1);
  }
}
