#!/bin/sh
set -euo pipefail
# https://www.techrepublic.com/article/how-to-enable-zram-rocky-linux/
# https://zhuanlan.zhihu.com/p/484408336
# /usr/share/doc/zram-generator/zram-generator.conf.example

echo ==================== 开启 zRAM  ====================
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../config/env.sh

enabled="$(systemctl status zram*)"
if [[ -z $enabled ]]; then
  dnf install -y zram-generator
  cp -u ${OS_DIR}/config/systemd/zram-generator.conf  /etc/systemd/
  sudo systemctl daemon-reload
  # sudo systemctl enable /dev/zram0 --now
  # sudo systemctl status /dev/zram0
  echo ">>  reboot and rucn zramctl to check zram status <<"
  echo -e "\n"
else
  echo ">>  zram is already enabled  <<"
  echo -e "\n"
fi

# sudo systemctl restart systemd-zram-setup@zram0.service
# sudo systemctl restart systemd-zram-setup@zram1.service

