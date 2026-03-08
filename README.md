# Primordial Soup WASM

A cellular automaton where programs written in a BF-like language compete, reproduce, and evolve on a 2D grid. Each cell holds a program (a tape of opcodes) that gets paired with neighbours, concatenated, and executed — rewriting both programs in the process. Random mutation introduces variation, and over time self-replicating patterns emerge from noise.

Copy of [Artificial Life](https://github.com/Rabrg/artificial-life/) by [Ryan Greene](https://x.com/rabrg), re-implemented in WebAssembly.

## Files

| File | Description |
|---|---|
| `assembly_index.ts` | AssemblyScript source for the simulation core (reference / documentation only — the compiled `.wat` is the actual source of truth) |
| `primordial_soup.wat` | WebAssembly Text Format — the simulation engine (init, step, render, RNG, BF interpreter) |
| `build.sh` | Compiles `.wat` → `.wasm` into `dist/` |
| `dist/index.html` | Single-page app — UI, controls, canvas renderer, tooltip |
| `dist/primordial_soup.wasm` | Compiled WASM binary (output of `build.sh`) |

## Development

### Prerequisites

- [wabt](https://github.com/WebAssembly/wabt) — for `wat2wasm` (or use via `npx`)
  ```
  brew install wabt
  ```

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

## Deploy

The `dist/` folder is self-contained and can be deployed to any static hosting (GitHub Pages, Netlify, Vercel, Cloudflare Pages, S3, etc.). It contains just two files:

- `index.html`
- `primordial_soup.wasm`

No build step is needed for deployment — just upload `dist/`.
