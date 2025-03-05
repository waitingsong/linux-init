#!/bin/sh
set -euo pipefail
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/config/env.sh

cp -f ${SRC}/script/* /usr/bin/

if [ ! -f ~/.ssh/id_ed25519 ]; then
  ssh-keygen -t ed25519 -N '' -f ~/.ssh/id_ed25519
fi
mkdir -p ~/.vim/swp


cd ${BASE}
sh .githooks/set-scripts-executable-now.sh

cd ${OS_DIR}
set -x
sh/ssh-sync-authorized_keys.sh root
sh/ssh-no-password.sh root
set-mirror-repo.sh
dnf makecache
sh/install-global-nvm.sh root
sudo -u root sh/install-nvm.sh
sh/set-config.global.sh
sh/turn-zram-on.sh
sh/turn-selinux-off.sh
sh/install-zfs.sh

set +x
echo -e "\n"
echo -------------------------------------------------------------------------
# echo "Run command: \"npm i --prod\" under \"${BASE}\" after reboot!"
echo "3秒后重启系统"
echo "运行 zpool-create data <disk> 创建默认 ZFS 存储池"
echo -------------------------------------------------------------------------
echo -e "\n"
sleep 3
reboot

