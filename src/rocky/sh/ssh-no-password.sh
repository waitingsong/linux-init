#!/bin/bash
# Must run with sudo -u <user> $0 <user>
set -euo pipefail
curr_user=$(whoami)
user=$1

if [[ -z $user ]]; then
  echo No user defined
  exit 1
fi

if [[ $user != $curr_user ]]; then
  echo "Please run this script as $user, eg. sudo -u $user $0 $user"
  exit 1
fi


# ssh-copy-id -i ~/.ssh/id_ed25519.pub  root@<ip|服务器名|域名>
# ssh-copy-id -i ~/.ssh/id_ed25519.pub "-p 1022 root@<ip|服务器名|域名>"

echo ==================== SSH 设置免密登录 $user ====================

# functions code from pigsty configure

function can_nopass_ssh(){
  local ipaddr=${2-'127.0.0.1'}
  if ssh -oBatchMode=yes -o "StrictHostKeyChecking no" ${user}@${ipaddr} 'ls' 1>/dev/null 2>/dev/null; then
    return 0
  else
    return 1
  fi
}

function fix_nopass_ssh(){
  [[ ! -d ~/.ssh ]] && mkdir -p ~/.ssh && chmod 0700 ~/.ssh;
  [[ ! -f ~/.ssh/id_ed25519 ]] && ssh-keygen -q -t ed25519 -N '' -f ~/.ssh/id_ed25519
  touch ~/.ssh/authorized_keys && chmod 0600 ~/.ssh/{authorized_keys,id_ed25519}

  local publicKey=$(cat ~/.ssh/id_ed25519.pub 2>/dev/null)
  if ! grep -q "${publicKey}" ~/.ssh/authorized_keys; then
    cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys
  fi
  return $(can_nopass_ssh)
}

function check_ssh(){
  if can_nopass_ssh ; then
    echo "ssh = $user@127.0.0.1 ok"
    return 0
  fi
  if fix_nopass_ssh; then
    echo "ssh = $user@127.0.0.1 fixed"
    return 0
  else
    echo "ssh = $user@127.0.0.1 failed. Maybe the user is not in AllowUsers or the public key is not in authorized_keys."
    exit 1
  fi
}

check_ssh

