#!/bin/sh
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../config/env.sh

sh/install-apps.sh

