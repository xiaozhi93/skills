#!/bin/bash

echo "=== 环境检查 ==="

# 检查 NVM
if command -v nvm &> /dev/null; then
    echo "✅ NVM 已安装: $(nvm --version)"
else
    echo "❌ NVM 未安装"
fi

# 检查 Node.js
if command -v node &> /dev/null; then
    echo "✅ Node.js 已安装: $(node --version)"
else
    echo "❌ Node.js 未安装"
fi

# 检查 npm
if command -v npm &> /dev/null; then
    echo "✅ npm 已安装: $(npm --version)"
else
    echo "❌ npm 未安装"
fi

# 检查 Python
if command -v python3 &> /dev/null; then
    echo "✅ Python3 已安装: $(python3 --version)"
elif command -v python &> /dev/null; then
    echo "✅ Python 已安装: $(python --version)"
else
    echo "❌ Python 未安装"
fi

# 检查 Git
if command -v git &> /dev/null; then
    echo "✅ Git 已安装: $(git --version)"
else
    echo "❌ Git 未安装"
fi

# 检查系统信息
echo ""
echo "=== 系统信息 ==="
uname -a
if command -v lsb_release &> /dev/null; then
    lsb_release -a
elif [ -f /etc/os-release ]; then
    cat /etc/os-release
elif [ -f /etc/redhat-release ]; then
    cat /etc/redhat-release
fi
