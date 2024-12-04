#!/bin/sh
set -eo pipefail
ip=$1
port=${2:-7890}


function run {
  if [[ -z $ip ]]; then
    echo -e "Usage: source $SCRIPT_NAME <ip> [port]\n"
  else
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
    cd "$DIR"
    export github_proxy_ip="$ip"
    export github_proxy_port="$port"
    echo github_proxy_ip: $github_proxy_ip, github_proxy_port: $github_proxy_port
  fi
}

while true; do
  echo -n "[提问] "; read -e -p "ip $ip, port $port. 确认使用 . 或者 source 来导入执行本脚本，而非直接执行脚本? [y|n] " -i "" yn
  case ${yn} in
    [Nn]*) break;;
    [Yy]*)
      run
      break;;
    *)     echo '输入 (y)es or (n)o';;
  esac;
done;

set +e

