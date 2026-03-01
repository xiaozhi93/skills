#!/bin/bash

# 环境安装主脚本

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "🚀 开始环境安装过程"

# 1. 检查当前环境
echo ""
echo "=== 步骤 1: 检查现有环境 ==="
"$SCRIPT_DIR/check_env.sh"

# 2. 安装所需环境
echo ""
echo "=== 步骤 2: 安装缺失的环境 ==="

# 检查并安装 NVM
if ! command -v nvm &> /dev/null; then
    "$SCRIPT_DIR/install_nvm.sh"
    # 重新加载 shell 以使用 nvm
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
else
    echo "✅ NVM 已安装"
fi

# 检查并安装 Node.js
if ! command -v node &> /dev/null; then
    "$SCRIPT_DIR/install_node.sh"
else
    echo "✅ Node.js 已安装"
fi

# 检查并安装 Python
PYTHON_INSTALLED=false
if (command -v python3 &> /dev/null || command -v python &> /dev/null); then
    # 检查是否为 Windows 应用商店版本
    if [ -f "/c/Users/Administrator/AppData/Local/Microsoft/WindowsApps/python.exe" ] || [ -f "/c/Users/Administrator/AppData/Local/Microsoft/WindowsApps/python3.exe" ]; then
        echo "⚠️  检测到 Windows 应用商店版本的 Python"
        echo "🔧 正在卸载 Windows 应用商店版本的 Python..."
        "$SCRIPT_DIR/uninstall_python.sh"
        # 检查是否成功卸载
        if (command -v python3 &> /dev/null || command -v python &> /dev/null); then
            echo "⚠️  无法完全卸载，请手动从 Windows 设置中卸载"
            read -p "按回车键继续..."
        else
            echo "✅ 已成功卸载，现在安装官方版本..."
            "$SCRIPT_DIR/install_python.sh"
            PYTHON_INSTALLED=true
        fi
    else
        echo "✅ Python 已安装（非 Windows 应用商店版本）"
        PYTHON_INSTALLED=true
    fi
else
    echo "📦 Python 未安装，正在安装..."
    "$SCRIPT_DIR/install_python.sh"
    PYTHON_INSTALLED=true
fi

# 检查并安装 openClaw
PYTHON_CMD="python3"
if ! command -v python3 &> /dev/null; then
    PYTHON_CMD="python"
fi

if ! $PYTHON_CMD -c "import openclaw2" 2>/dev/null; then
    "$SCRIPT_DIR/install_openclaw.sh"
else
    echo "✅ openClaw 已安装"
fi

# 3. 测试环境
echo ""
echo "=== 步骤 3: 测试安装的环境 ==="
"$SCRIPT_DIR/test_env.sh"

echo ""
echo "🎉 环境安装过程完成！"
