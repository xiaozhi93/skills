#!/bin/bash

echo "=== 安装 Node.js ==="

# 检查 NVM 是否可用
if ! command -v nvm &> /dev/null; then
    echo "❌ NVM 未找到，请先安装 NVM"
    exit 1
fi

# 获取最新稳定版本
LTS_VERSION=$(nvm ls-remote --lts | tail -1 | awk '{print $NF}')

echo "📦 安装 Node.js 稳定版本: $LTS_VERSION"

# 安装 Node.js
nvm install $LTS_VERSION

# 设置为默认版本
nvm use $LTS_VERSION
nvm alias default $LTS_VERSION

echo "✅ Node.js 安装完成"
node --version
npm --version
