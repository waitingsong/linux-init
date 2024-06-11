#!/bin/bash
set -euo pipefail

echo ==================== 系统性能调整 ====================
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../config/env.sh

cp -u config/sysctl.d/* /etc/sysctl.d/
sysctl -p
# sysctl -a
# systemd-analyze cat-config sysctl.d
systemd-analyze cat-config /usr/lib/sysctl.d/*-custom.conf | head -n 40

