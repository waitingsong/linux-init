#!/bin/sh
set -euo pipefail
# https://pigsty.cc/zh/docs/setup/install/

echo ==================== 安装 pigsty 命令行 ====================

dnf -y install ansible python3-jmespath createrepo_c modulemd-tools sshpass
# curl https://repo.pigsty.io/pig | bash    # cloudflare
curl https://repo.pigsty.cc/pig | bash    # china cdn

