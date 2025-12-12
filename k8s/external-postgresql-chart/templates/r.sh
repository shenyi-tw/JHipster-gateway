#!/bin/bash

# 偵測本地 IP (Wi-Fi: en0, 有線: en1)
LOCAL_IP=$(ipconfig getifaddr en0)

if [ -z "$LOCAL_IP" ]; then
  echo "無法取得本機 IP，請確認網路連線。"
  exit 1
fi

# 使用 template.yaml 生成最終 YAML
export LOCAL_IP
envsubst < template.yaml > endpoints.yaml

echo "已生成 endpoints.yaml，IP = $LOCAL_IP"
