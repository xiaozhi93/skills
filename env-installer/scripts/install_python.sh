#!/bin/bash

echo "=== 安装 Python ==="

# 检查是否已安装
if command -v python3 &> /dev/null; then
    echo "✅ Python3 已安装: $(python3 --version)"
    exit 0
elif command -v python &> /dev/null; then
    echo "✅ Python 已安装: $(python --version)"
    exit 0
fi

OS=$(uname -s)

case "$OS" in
    Linux*)
        echo "📦 Linux 系统安装 Python"
        if command -v apt-get &> /dev/null; then
            sudo apt-get update
            sudo apt-get install -y python3 python3-pip
        elif command -v yum &> /dev/null; then
            sudo yum install -y python3 python3-pip
        elif command -v dnf &> /dev/null; then
            sudo dnf install -y python3 python3-pip
        else
            echo "❌ 不支持的包管理器"
            exit 1
        fi
        ;;
    Darwin*)
        echo "🍎 macOS 系统安装 Python"
        if command -v brew &> /dev/null; then
            brew install python3
        else
            echo "请先安装 Homebrew"
            exit 1
        fi
        ;;
    MINGW*|CYGWIN*|MSYS*)
        echo "🪟 Windows 系统安装 Python"
        if command -v winget &> /dev/null; then
            winget install Python.Python.3.12
        else
            echo "请先安装 Winget 或手动下载安装"
            echo "下载地址: https://www.python.org/downloads/"
            exit 1
        fi
        ;;
    *)
        echo "❓ 未知操作系统: $OS"
        exit 1
        ;;
esac

echo "✅ Python 安装完成"

if command -v python3 &> /dev/null; then
    python3 --version
elif command -v python &> /dev/null; then
    python --version
fi
