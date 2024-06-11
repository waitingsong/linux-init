#!/bin/sh
set -euo pipefail
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
cd "$DIR"

sh/$SCRIPT_NAME

