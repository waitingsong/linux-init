#!/bin/sh
set -e
user=$( whoami )

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../config/env.sh

echo -e "--------- install node core pkgs for $user --------- "

if [[ -z $NVM_DIR ]]; then
  echo "NVM_DIR is not set"
  exit 1
fi
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


if [[ -n $NPM_REG_MIRROR ]]; then
  echo -e "--------- change node registry for $user --------- "
  npm -g config set registry $NPM_REG_MIRROR
fi

if [[ ! -x "$(command -v nrm)" ]]; then
  echo -e "--------- install nrm for $user --------- "
  npm i -g nrm
  nrm use taobao
fi

if [[ ! -x "$(command -v tsx)" ]]; then
  npm i -g \
    tsx \
    typescript \
    zx \

fi


