#!/bin/bash
set -euo pipefail

ip=$1
port=$2

if [[ $ip == "" ]]; then
  ip="127.0.0.1"
  echo Use default local ip: $ip
fi

if [[ $port == "" ]]; then
  port=7890
  echo Use default port: $port
fi

export https_proxy=http://$ip:$port
export http_proxy=http://$ip:$port
export all_proxy=socks5://$ip:$port

