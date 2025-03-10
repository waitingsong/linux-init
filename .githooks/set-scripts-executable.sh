#!/bin/bash
set +e

dirs=".scripts .github src bin"

for dir in $dirs; do
  [[ -d "$dir" ]] && find $dir -type f \( -iname "*.sh" -o -iname "*.mjs" -o -iname "*.mts" \) -print0 | xargs -0II git update-index --ignore-missing --chmod=+x I
done

find .githooks -type f -print0 | xargs -0II git update-index --ignore-missing --chmod=+x I
find src/script -type f -print0 | xargs -0II git update-index --ignore-missing --chmod=+x I

echo "Commit changes if changed!"

set -e

