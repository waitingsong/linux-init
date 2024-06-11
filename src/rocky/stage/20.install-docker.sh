#!/bin/sh
set -e
force=$1

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../config/env.sh


if [[ -n $(command -v docker) && "$(systemctl is-active docker)" = 'active' && -z $force ]]; then
  echo "docker is already installed and active."
else
  sh/install-docker.sh
fi


