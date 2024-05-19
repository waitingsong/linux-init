#!/bin/sh
set -euo pipefail
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../config/env.sh

# cp -u config/NetworkManager/conf.d/80-dnsmasq.conf /etc/NetworkManager/conf.d/
cp -u config/NetworkManager/conf.d/90-dns-none.conf /etc/NetworkManager/conf.d/
# 删除 /etc/resolv.conf 文件第一行的注解
sed -i '/^# Generated/d' /etc/resolv.conf
sed -i '0,/nameserver/{s/nameserver/nameserver 127.0.0.1\n&/}' /etc/resolv.conf
echo 'options single-request-reopen timeout:1 edns0 trust-ad' >> /etc/resolve.conf
cp -u config/dnsmasq.d/server.dnsmasq.conf /etc/dnsmasq.d/

