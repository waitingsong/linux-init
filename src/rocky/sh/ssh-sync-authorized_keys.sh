#!/bin/bash
set -euo pipefail
user=$1

if [[ -z $user ]]; then
  echo No user defined
  exit 1
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../config/env.sh


if [[ $user == "root" ]]; then
  echo ==================== Copy authorized_keys user: ${user} ====================
  mkdir -p /root/.ssh
  cp -u config/ssh/authorized_keys /root/.ssh/
  chmod 0600 /root/.ssh/authorized_keys
elif [[ -d /home/${user} ]]; then
  echo ==================== Copy authorized_keys user: ${user} ====================
  mkdir -p /home/${user}/.ssh
  cp -u config/ssh/authorized_keys /home/${user}/.ssh/
  chmod 0600 /home/${user}/.ssh/authorized_keys
  chown -R ${user}:${user} /home/${user}/.ssh/
fi

