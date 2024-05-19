#!/bin/bash
set -euo pipefail
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../config/env.sh

sudo cp -f /etc/ssh/sshd_config /etc/ssh/ori_sshd_config
sh/ssh-ed25519-rsa-only.sh
sudo systemctl restart sshd
sh/ssh-login-cert-only.sh
sudo cp /etc/ssh/sshd_config{,.ok}

