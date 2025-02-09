#!/bin/sh
set -euo pipefail
echo ==================== 拷贝配置文件 ====================
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../config/env.sh

# 增加最大打开文件句柄数量
echo 'ulimit -SHn 65535' >> /etc/rc.local

# VIM
cp -u config/.vimrc /root/

cp -u config/profile.d/* /etc/profile.d/
cp -u config/bash_completion.d/* /etc/bash_completion.d/

echo ==================== 设置 rc.local 自动执行 ====================
chmod +x /etc/rc.d/rc.local
# systemctl status rc-local.service | head -n 20


# nmcli connection show
# nmcli connection modify "ens160" ipv4.dns 114.114.114.114
# nmcli connection show ens160

