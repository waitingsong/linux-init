#!/bin/sh
set -euo pipefail
# github proxy https://github.com/runningcheese/MirrorSite
echo ==================== 安装 Docker Compose ====================

url="https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-linux-x86_64"
url_roxy="https://mirror.ghproxy.com/"

echo github_proxy_ip: $github_proxy_ip, github_proxy_port: $github_proxy_port

if [[ -z "$github_proxy_ip" ]]; then
  echo ">> 使用代理 mirror.ghproxy.com 下载 docker-compose"
  curl -L "${url_roxy}${url}" -o /tmp/docker-compose
else
  echo ">> 使用代理 ${github_proxy_ip} 下载 docker-compose"
  curl -x $github_proxy_ip:$github_proxy_port -L "$url" -o /tmp/docker-compose
fi
sudo chown root:root /tmp/docker-compose
sudo chmod 755 /tmp/docker-compose
mv -f /tmp/docker-compose /usr/local/bin/docker-compose

docker-compose version
echo -e "\n"

# docker run --rm docker.nju.edu.cn/library/hello-world
# docker run --rm docker.nju.edu.cn/library/alpine uname -a

