#!/bin/bash
set -euo pipefail
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
cd "$DIR"

# ssh-copy-id -i ~/.ssh/id_ed25519.pub  root@<ip|服务器名|域名>
# ssh-copy-id -i ~/.ssh/id_ed25519.pub "-p 1022 root@<ip|服务器名|域名>"
sh/$SCRIPT_NAME

set +eu
