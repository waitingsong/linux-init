#!/bin/bash
set -euo pipefail
echo ==================== 更新本地配置文件 .profile ====================
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../config/env.sh

sh/set-config.global.sh

