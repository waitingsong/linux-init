#!/bin/bash
set -euo pipefail
echo ==================== 更新本地配置文件 .profile ====================
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../config/env.sh

sudo -u root sh/set-config.local.sh
sudo -u admin sh/set-config.local.sh
sudo -u dba sh/set-config.local.sh
sudo -u ci sh/set-config.local.sh

