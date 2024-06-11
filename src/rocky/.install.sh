#!/bin/sh
set -euo pipefail
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/config/env.sh

echo Current dir:
pwd
echo -e "\n"


echo ==================== 初始化 Rocky ====================
set -x

npm i --prod
stage/00.pre-install.sh
stage/01.ssh-config.sh
stage/03.batch-create-user.mts # stage/02.user.sh
stage/04.set-config.global.sh
stage/05.set-config.local.sh
stage/10.install-apps.sh
stage/13.user-nvm.sh
stage/14.tune.sh
stage/17.service.sh
stage/20.install-docker.sh
stage/21.install-docker-compose.sh
stage/90.update-crt.sh
# stage/91.turn-zram-on.sh
stage/99.post-install.sh

set +x
echo ==================== 5秒后重启系统 ====================
sleep 5
reboot

