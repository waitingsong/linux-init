#!/bin/sh
set -euo pipefail
# https://pigsty.cc/zh/docs/setup/install/

echo ==================== 安装 pigsty 命令行 ====================

# dnf install -y ansible python3.11-jmespath
curl -fsSL https://repo.pigsty.io/pig | bash

