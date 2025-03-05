#!/bin/bash
set -euo pipefail
user=$( whoami )
echo ==================== 更新 ${user} 本地配置文件 ====================

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../config/env.sh

# VIM
cp -u config/.vimrc ~/

# 更新本地设置
cat>> ~/.profile <<EOF
export PATH="/usr/local/bin:\$PATH"
# df -lhT
EOF

