#!/bin/sh
set -eo pipefail
ip=$1
port=${2:-7890}

echo -e "Usage: source $0 <ip> [port:7890]\n"

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  echo "错误: 脚本必须通过 source 执行"
  return
fi

if [[ $ip == "" ]]; then
  echo "错误: 请指定代理服务器 IP"
  return
fi

if [[ $port == "" ]]; then
  port=7890
  echo Use default port: $port
fi

export https_proxy=http://$ip:$port
export http_proxy=http://$ip:$port
export all_proxy=socks5://$ip:$port
export no_proxy="localhost,127.0.0.1,10.0.0.0/8,192.168.0.0/16,*.pigsty,*.aliyun.com,mirrors.*,*.myqcloud.com,*.tsinghua.edu.cn"

echo https_proxy: $https_proxy
echo http_proxy: $http_proxy
echo all_proxy: $all_proxy
echo no_proxy: $no_proxy
set +e

