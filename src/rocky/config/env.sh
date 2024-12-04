#!/bin/sh
set -eo pipefail
# DIR="$(dirname "$(readlink -f "$0")")" # 不能正确处理 source 调用的情况
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export OS_DIR="$(realpath ${DIR}/../)"
export BASE="$(realpath ${OS_DIR}/../../)"
export SRC="$(realpath ${OS_DIR}/../)"
export ASSERT="$(realpath ${OS_DIR}/../../asset)"

export NVM_DIR="$HOME/.nvm"
# export NVM_NODEJS_ORG_MIRROR="https://npmmirror.com/dist"
export NVM_NODEJS_ORG_MIRROR="https://mirrors.aliyun.com/nodejs-release"
export NPM_REG_MIRROR="https://registry.npmmirror.com"

export no_proxy="localhost,127.0.0.1,10.0.0.0/8,192.168.0.0/16,*.pigsty,*.aliyun.com,mirrors.*,mirror.*,*.myqcloud.com,*.tsinghua.edu.cn,*.fedoraproject.org"

cd ${OS_DIR}

