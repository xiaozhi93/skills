#!/bin/bash

echo "=== 安装 NVM ==="

# 检查是否已安装
if command -v nvm &> /dev/null; then
    echo "✅ NVM 已安装: $(nvm --version)"
    exit 0
fi

# 根据系统类型选择安装方法
OS=$(uname -s)

case "$OS" in
    Linux*)
        echo "📦 Linux 系统安装 NVM"
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
        ;;
    Darwin*)
        echo "🍎 macOS 系统安装 NVM"
        # 使用 Homebrew 安装
        if command -v brew &> /dev/null; then
            brew install nvm
        else
            echo "请先安装 Homebrew"
            exit 1
        fi
        ;;
    MINGW*|CYGWIN*|MSYS*)
        echo "🪟 Windows (MSYS2) 系统安装 NVM"
        # 使用 winget 安装
        if command -v winget &> /dev/null; then
            winget install CoreyButler.NVMforWindows
        else
            echo "请先安装 Winget 包管理器或手动下载安装"
            echo "下载地址: https://github.com/coreybutler/nvm-windows/releases"
            exit 1
        fi
        ;;
    *)
        echo "❓ 未知操作系统: $OS"
        exit 1
        ;;
esac

echo "✅ NVM 安装完成"
echo "⚠️  请重启终端或运行以下命令加载 NVM:"
echo "  source ~/.bashrc"
echo "  source ~/.zshrc"
