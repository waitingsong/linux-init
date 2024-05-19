#!/bin/sh
set -euo pipefail
user=$1
sudoWithoutPassword=$2

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../config/env.sh

echo -e "--------- Set sudoer for $user --------- "
if [ -z "$user" ]; then
  echo "Usage: $0 <user>"
  exit 1
fi

# cp -u config/sudoers.d/* /etc/sudoers.d/

rm -f /etc/sudoers.d/$user
echo "Defaults: ${user}   timestamp_timeout=15" > /etc/sudoers.d/$user


if [[ $sudoWithoutPassword == "true" ]]; then
  echo "user $user: sudo without password"
  echo "$user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$user
else
  echo "$user ALL=(ALL) ALL" >> /etc/sudoers.d/$user
fi

chmod 440 /etc/sudoers.d/*
chown root:root /etc/sudoers.d/*

