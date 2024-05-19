#!/bin/sh
set -euo pipefail
ip=$1
port=${2:-7890}

while true; do
  echo -n "[提问] "; read -e -p "ip $ip, port $port. 确认使用 . 或者 source 来导入执行本脚本，而非直接执行脚本? [y|n] " -i "" yn
  case ${yn} in
    [Nn]*) exit 1;;
    [Yy]*) break;;
    *)     echo '输入 (y)es or (n)o';;
  esac;
done;

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
cd "$DIR"

if [[ -z $ip ]]; then
  echo "Usage: source $SCRIPT_NAME <ip> [port]"
  exit 1
fi

export github_proxy_ip="$ip"
export github_proxy_port="$port"

echo github_proxy_ip: $github_proxy_ip, github_proxy_port: $github_proxy_port

