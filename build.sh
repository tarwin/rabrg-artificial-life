#!/usr/bin/env bash
set -euo pipefail

# Build primordial_soup.wat → dist/primordial_soup.wasm
# Requires: wabt (brew install wabt) or npx wabt

OUT="dist/primordial_soup.wasm"

if command -v wat2wasm &>/dev/null; then
  wat2wasm primordial_soup.wat -o "$OUT"
elif command -v npx &>/dev/null; then
  npx wat2wasm primordial_soup.wat -o "$OUT"
else
  echo "Error: wat2wasm not found. Install wabt (brew install wabt) or use npx." >&2
  exit 1
fi

echo "Built $OUT ($(wc -c < "$OUT" | tr -d ' ') bytes)"
