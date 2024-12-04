#!/bin/sh
set -euo pipefail
force=$1

echo ==================== 安装全局 nvm ====================
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../config/env.sh

dnf install -y git tar unzip

rm -rf /usr/local/nvm
if [[ ! -d /usr/local/nvm ]]; then
  # repo: https://github.com/nvm-sh/nvm
  # curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  unzip -oq "${ASSERT}/nvm.zip" -d /usr/local/
  cd /usr/local/nvm
  git reset --hard
  chmod a+x install.sh
  cd -
fi


# cd ${OS_DIR}
# sudo -u root ./sh/install-nvm.sh ext $force

