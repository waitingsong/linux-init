#!/bin/sh
set -euo pipefail
ip=$1
port=$2

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
echo "Note: use source command to run this script!"

. sh/$SCRIPT_NAME $ip $port
echo https_proxy: $https_proxy, http_proxy: $http_proxy, all_proxy: $all_proxy

