// ── Primordial Soup WASM Core ──────────────────────────────────────
// BF-variant cellular automaton compiled to WebAssembly via AssemblyScript

// Opcodes
const LT:   u8 = 60;   // <
const GT:   u8 = 62;   // >
const LB:   u8 = 123;  // {
const RB:   u8 = 125;  // }
const MINUS:u8 = 45;   // -
const PLUS: u8 = 43;   // +
const DOT:  u8 = 46;   // .
const COMMA:u8 = 44;   // ,
const LBRACK:u8 = 91;  // [
const RBRACK:u8 = 93;  // ]

// ── Simulation state ──
let gridWidth: i32 = 0;
let gridHeight: i32 = 0;
let tapeSize: i32 = 0;
let numPrograms: i32 = 0;
let maxIter: i32 = 8192;

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

  // Build neighborhood (5x5 minus self)
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

  // Build color LUT
  for (let i: i32 = 0; i < 256; i++) {
    setColor(colorLutPtr, i, 20, 20, 20);
  }
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
}

export function getPixelsPtr(): usize { return pixelsPtr; }
export function getPixelsLen(): i32 { return gridWidth * 8 * gridHeight * 8 * 4; }
export function getProgramsPtr(): usize { return programsPtr; }

// ── BF tape interpreter ──
function runTape(tapeBase: usize, sz: i32): void {
  let pc: i32 = 0;
  let head0: i32 = 0;
  let head1: i32 = 0;

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
  let total = numPrograms * tapeSize;
  for (let i: i32 = 0; i < total; i++) {
    if (<i32>rngBounded(<u32>rateDen) < rateNum) {
      store<u8>(programsPtr + <usize>i, <u8>(rngNextU32() & 0xFF));
    }
  }
}

@inline
function isOpcode(v: u8): bool {
  return v == LT || v == GT || v == LB || v == RB ||
         v == MINUS || v == PLUS || v == DOT || v == COMMA ||
         v == LBRACK || v == RBRACK;
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
