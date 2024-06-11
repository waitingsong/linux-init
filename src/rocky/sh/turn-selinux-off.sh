#!/bin/sh
set -euo pipefail

echo ==================== 关闭 SELinux ====================
# sudo setenforce 0
sed -i 's|SELINUX=\w*|SELINUX=disabled|' /etc/selinux/config
sestatus

echo "重启后生效"

