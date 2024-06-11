#!/bin/sh
set -euo pipefail

echo ==================== pre-install ====================

mkdir -p /root/.vim/swp

dnf install -y \
  curl \
  glibc-langpack-en langpacks-zh_CN langpacks-en \
  unzip \
  wget \
  zram-generator

localectl set-locale LANG=en_US.UTF-8
localectl status

# echo '
# LANG="en_US.UTF-8"
# LC_TIME="en_US.UTF-8"
# LC_MESSAGES="en_US.UTF-8"
# SUPPORTED="zh_CN.UTF-8:zh_CN.GB18030:zh_CN:zh:en_US.UTF-8:en_US:en"
# SYSFONT="latarcyrheb-sun16"
# ' >> /etc/locale.conf


# https://github.com/hashicorp/packer/issues/12489
if [[ -f /etc/lvm/devices/system.devices ]];then
  mv /etc/lvm/devices/system.devices /etc/lvm/devices/system.devices.bak
fi

