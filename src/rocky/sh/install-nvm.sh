#!/bin/sh
set -e
pkg=$1
force=$2
user=$( whoami )

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../config/env.sh

if [[ -z $NVM_DIR ]]; then
  echo "NVM_DIR is not set"
  exit 1
fi

if [[ -n $force ]]; then
  echo -e "--------- remove nvm for $user --------- "
  rm -rf $NVM_DIR
fi

if [[ ! -d $NVM_DIR ]]; then
  echo -e "--------- install nvm for $user --------- "
  # /usr/local/nvm/install.sh
  cp -a /usr/local/nvm ${NVM_DIR}
fi

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [[ ! -x "$(command -v npm)" ]]; then
  echo -e "--------- install node for $user --------- "
  set +u
  nvm install --lts
  nvm use --lts
fi

if [[ $pkg = 'ext' ]]; then
  sh/install-node-pkg-ext.sh
else
  sh/install-node-pkg.sh
fi

