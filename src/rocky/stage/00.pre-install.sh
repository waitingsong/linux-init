#!/bin/sh
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../config/env.sh

workDir=$(pwd)
echo "workDir: $workDir"

sh/pre-install.sh

set +eu
