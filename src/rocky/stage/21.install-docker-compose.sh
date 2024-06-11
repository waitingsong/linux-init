#!/bin/sh
set -e
force=$1

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../config/env.sh

if [[ -n $(command -v docker-compose) && -z $force ]]; then
  echo "docker-compose is already installed."
else
  sh/install-docker-compose.sh
fi

