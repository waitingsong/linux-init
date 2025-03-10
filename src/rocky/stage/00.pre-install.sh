#!/bin/sh
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../config/env.sh

workDir=$(pwd)
echo "workDir: $workDir"

dnf install -y wget curl
sh/update-cert.sh
sh/pre-install.sh
sh/util/install-vim-plugins.sh

set +eu
