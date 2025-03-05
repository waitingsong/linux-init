#!/bin/sh
set -eo pipefail
ip=$1
port=${2:-7890}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  echo "脚本需要被 sourced, 请使用 source $0 <ip> [port] 或者 . $0 <ip> [port] 的方式执行"
  exit 1
fi

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
run


set +e

