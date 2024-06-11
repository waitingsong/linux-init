#!/bin/bash
set -euo pipefail

echo ==================== 开启相关服务 ====================

echo ">> 计划任务"
systemctl enable --now crond

echo ">> DNS缓存"
systemctl enable --now dnsmasq

