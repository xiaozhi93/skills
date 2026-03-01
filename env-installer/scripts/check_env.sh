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

# 检查 openClaw
PYTHON_CMD="python3"
if ! command -v python3 &> /dev/null; then
    PYTHON_CMD="python"
fi

# 检查是否能成功执行 Python 命令（避免Windows应用商店的Python问题）
if ! $PYTHON_CMD --version 2>&1 >/dev/null; then
    echo "❌ Python 命令无法执行（Windows应用商店版本需要安装）"
else
    if $PYTHON_CMD -c "import openclaw" 2>/dev/null; then
        echo "✅ openClaw 已安装"
        # 检查版本
        PIP_CMD=""
        if command -v pip3 &> /dev/null; then
            PIP_CMD="pip3"
        elif command -v pip &> /dev/null; then
            PIP_CMD="pip"
        elif $PYTHON_CMD -m pip --version 2>&1 >/dev/null; then
            PIP_CMD="$PYTHON_CMD -m pip"
        fi

        if [ -n "$PIP_CMD" ]; then
            VERSION=""
            if [ "$PIP_CMD" = "pip3" ] || [ "$PIP_CMD" = "pip" ]; then
                VERSION=$($PIP_CMD list | grep -E "openclaw" | awk '{print $2}')
            elif [[ "$PIP_CMD" == *"python"* && "$PIP_CMD" == *"pip"* ]]; then
                VERSION=$($PIP_CMD list | grep -E "openclaw" | awk '{print $2}')
            fi
            if [ -n "$VERSION" ]; then
                echo "   版本: $VERSION"
            fi
        fi
    else
        echo "❌ openClaw 未安装"
    fi
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
