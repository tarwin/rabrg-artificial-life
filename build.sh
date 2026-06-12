#!/usr/bin/env bash
set -euo pipefail

# Build assembly_index.ts → dist/primordial_soup.wasm (+ primordial_soup.wat)
# Requires: node/npx (AssemblyScript compiler fetched via npx)

OUT="dist/primordial_soup.wasm"

npx -y -p assemblyscript asc assembly_index.ts \
  --outFile "$OUT" \
  --textFile primordial_soup.wat \
  --runtime stub \
  --noAssert \
  -O3

echo "Built $OUT ($(wc -c < "$OUT" | tr -d ' ') bytes)"
