# Primordial Soup WASM

A cellular automaton where programs written in a BF-like language compete, reproduce, and evolve on a 2D grid. Each cell holds a program (a tape of opcodes) that gets paired with neighbours, concatenated, and executed — rewriting both programs in the process. Random mutation introduces variation, and over time self-replicating patterns emerge from noise.

Copy of [Artificial Life](https://github.com/Rabrg/artificial-life/) by [Ryan Greene](https://x.com/rabrg), re-implemented in WebAssembly.

## Files

| File | Description |
|---|---|
| `assembly_index.ts` | AssemblyScript source for the simulation core — **the source of truth**, compiled to WASM by `build.sh` |
| `primordial_soup.wat` | WebAssembly Text Format — generated build artifact (for inspection) |
| `build.sh` | Compiles `assembly_index.ts` → `dist/primordial_soup.wasm` (+ regenerates the `.wat`) |
| `dist/index.html` | Single-page app — UI, controls, canvas renderer, specimen magnifier |
| `dist/primordial_soup.wasm` | Compiled WASM binary (output of `build.sh`) |

## Language versions

The instruction set is versioned and cumulative. The active version can be switched live in the UI (keys `1`–`3`) — bytes that aren't opcodes in the current version are inert junk DNA, so raising the version reinterprets the same soup with more active instructions.

### Lang Ⅰ — classic (original 10 opcodes)

| Op | Byte | Effect |
|---|---|---|
| `<` `>` | 60, 62 | move head0 left / right (wraps) |
| `{` `}` | 123, 125 | move head1 left / right (wraps) |
| `-` `+` | 45, 43 | decrement / increment byte at head0 |
| `.` | 46 | copy byte at head0 → head1 |
| `,` | 44 | copy byte at head1 → head0 |
| `[` `]` | 91, 93 | loop: jump forward if byte at head0 is 0 / jump back if non-0 |

### Lang Ⅱ — spatial (adds 4)

Treats the tape as rows of 8 bytes — the same 8×8 layout each program is rendered as, so these move a head "vertically" through the visible tile.

| Op | Byte | Effect |
|---|---|---|
| `^` `v` | 94, 118 | move head0 up / down one row (±8, wraps) |
| `(` `)` | 40, 41 | move head1 up / down one row |

### Lang Ⅲ — extended (adds 4 more)

| Op | Byte | Effect |
|---|---|---|
| `0` | 48 | zero the byte at head0 |
| `@` | 64 | swap head0 and head1 positions |
| `!` | 33 | swap the bytes at head0 and head1 |
| `?` | 63 | write a random byte at head0 |

The engine exports `setLangVersion(v)` / `getLangVersion()`; rendering and the opcode-density stat are version-aware.

## Ecology options (experimental)

These change the *ecology* around the soup — how cells interact and where mutation falls — without touching the BF language. The classic well-mixed behaviour is the default, so you can toggle them on and compare. Found in the ⚙ settings popover.

The motivation: with the classic rules everything tends to collapse into a single dominant self-replicator (a monoculture). These options fight the two causes of that — well-mixed pairing, and a perfectly uniform world — so competing lineages can form **domains, boundaries, and coexistence** instead.

### Coupling — how a cell picks its partner

| Mode | Behaviour |
|---|---|
| `5×5 random` | classic — partner is any of the 24 cells in the surrounding 5×5 (well-mixed) |
| `4-neighbour` | von Neumann — partner is one of the 4 orthogonal neighbours; tighter locality → slower spread → visible domain walls |
| `sweep` | directional — the pairing axis alternates horizontal/vertical each epoch; anisotropic coupling that tends to produce fronts and waves |

`setCoupling(mode)` / `getCoupling()`.

### Substrate field

A smooth static terrain baked over the grid that scales the **local** mutation rate. Low-field basins are *refuges* (low mutation — patterns persist), high-field channels are *barriers* (high mutation — bytes scramble, lineages can't cross). This creates niches so different replicators settle and persist side by side.

- **strength** — 0 disables the effect; 100 maps the field to 0× … 2× the base mutation rate.
- **new terrain** — reroll the field with a fresh seed.
- **show terrain** (`T`) — overlay the field as a teal→amber heatmap.

`setSubstrate(on, strength)`, `regenSubstrate(seed)`, `getSubstratePtr()` / `getSubstrateLen()`.

## Development

### Prerequisites

- Node.js / `npx` — the [AssemblyScript](https://www.assemblyscript.org/) compiler is fetched automatically via `npx`

### Build

```bash
./build.sh
```

### Run locally

Serve the `dist/` directory with any static file server:

```bash
cd dist && python3 -m http.server 8000
# or
npx serve dist
```

Then open `http://localhost:8000`.

> **Note:** The app fetches `primordial_soup.wasm` at runtime, so it must be served over HTTP — opening `index.html` via `file://` won't work.

### UI shortcuts

| Key | Action |
|---|---|
| `space` | play / pause |
| `S` | single epoch |
| `R` | reseed with a random seed |
| `1`–`3` | switch language version |
| `/` | hide / show the interface |
| `G` | toggle grid lines |
| `P` | toggle the opcode-census plot (each opcode's total count over time) |
| `T` | toggle the substrate-terrain overlay |
| click | pin a specimen — live magnified view + genome readout follows it |

## Deploy

The `dist/` folder is self-contained and can be deployed to any static hosting (GitHub Pages, Netlify, Vercel, Cloudflare Pages, S3, etc.). It contains just two files:

- `index.html`
- `primordial_soup.wasm`

No build step is needed for deployment — just upload `dist/`.
