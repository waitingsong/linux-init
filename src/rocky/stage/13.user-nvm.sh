#!/bin/sh
set -eo pipefail
force=$1
echo ==================== 安装 nvm nodejs ====================
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../config/env.sh

# sudo -u root ./sh/install-nvm.sh ext $force
sudo -u admin sh/install-nvm.sh core $force
sudo -u dba sh/install-nvm.sh ext $force
sudo -u ci sh/install-nvm.sh core $force

