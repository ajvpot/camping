#!/usr/bin/env bash
set -euxo pipefail;

mkdir -p results logs

# Iterate over each .yml file in the results directory
for config_file in searches/*.yml; do
  # Extract the file name without extension
  filename=$(basename -- "$config_file")
  filename="${filename%.*}"

  # Run camply campsites --config and redirect output to a file
  (set -euo pipefail; camply campsites --yaml-config "$config_file" \
    --search-once --equipment Tent 0 \
    --offline-search --offline-search-path "results/${filename}.json" 2>&1 | tee "logs/${filename}.log" ) &
done

wait