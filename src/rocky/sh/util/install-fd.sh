#!/bin/sh
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../../config/env.sh

echo ==================== 安装 fd  ====================

# https://github.com/sharkdp/fd
dnf -y copr enable tkbcopr/fd
dnf -y install fd

