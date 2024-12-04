#!/bin/bash
set -euo pipefail
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../config/env.sh

sudo cp -f /etc/ssh/sshd_config /etc/ssh/ori_sshd_config
sudo cp -f config/sshd_config.d/* /etc/ssh/sshd_config.d/

sh/ssh-ed25519-rsa-only.sh
sudo systemctl restart sshd
sh/ssh-login-cert-only.sh
sudo cp /etc/ssh/sshd_config{,.ok}

set +eu
