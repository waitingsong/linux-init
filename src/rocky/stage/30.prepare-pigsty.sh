#!/bin/sh
set -euo pipefail
# https://pigsty.cc/zh/docs/setup/install/
echo ==================== 安装 Pigsty ====================
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../config/env.sh


sh/prepare-pigsty.sh


