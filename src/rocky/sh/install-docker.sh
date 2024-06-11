#!/bin/sh
set -euo pipefail

echo ==================== 安装 Docker ====================
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../config/env.sh

# dnf remove -y \
#   selinux-policy \

dnf remove -y \
  docker \
  docker-client \
  docker-client-latest \
  docker-common \
  docker-latest \
  docker-latest-logrotate \
  docker-logrotate \
  docker-engine

dnf install -y device-mapper-persistent-data lvm2

# dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
# dnf config-manager --add-repo https://mirrors.cloud.tencent.com/docker-ce/linux/centos/docker-ce.repo

dnf makecache

d1="/data/docker"
d2="/data/.docker"
d3="/etc/docker"
mkdir -p $d1 $d2 $d3
chown docker:docker $d1 $d2
chmod 775 $d1 $d2

# dnf list docker-ce --showduplicates | sort -r
# dnf -y install docker-ce-[VERSION] docker-ce-cli-[VERSION]

dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
# dnf remove -y pcp-selinux
systemctl enable docker --now
docker version

if [ ! -f /etc/docker/daemon.json ]; then
  cp -u ${OS_DIR}/config/docker/daemon.json /etc/docker/
fi
cat /etc/docker/daemon.json
systemctl restart docker

systemctl status docker | head -n 20


