#!/usr/bin/env bash
set -euo pipefail

[[ $# -eq 2 ]] || { echo "Usage: $0 INPUT_DIR OUTPUT_DIR"; exit 1; }
input_dir=$1
output_dir=$2
[[ -d $input_dir ]] || exit 1
mkdir -p "$output_dir"

find "$input_dir" -type f -print0 | while IFS= read -r -d '' file; do
  base=$(basename "$file")
  dest="$output_dir/$base"
  if [[ -e "$dest" ]]; then
    name="${base%.*}"
    ext="${base#$name}"
    i=1
    while [[ -e "$output_dir/$name$i$ext" ]]; do ((i++)); done
    dest="$output_dir/$name$i$ext"
  fi
  cp "$file" "$dest"
done
