#!/bin/bash

echo "=== 安装 openClaw ==="

# 检查是否已安装 Python
if ! (command -v python3 &> /dev/null || command -v python &> /dev/null); then
    echo "❌ Python 未安装，请先安装 Python"
    exit 1
fi

# 检查是否已安装 pip
PIP_FOUND=false
if command -v pip3 &> /dev/null; then
    PIP_CMD="pip3"
    PIP_FOUND=true
elif command -v pip &> /dev/null; then
    PIP_CMD="pip"
    PIP_FOUND=true
elif $PYTHON_CMD -m pip --version 2>&1 >/dev/null; then
    PIP_CMD="$PYTHON_CMD -m pip"
    PIP_FOUND=true
else
    echo "❌ pip 未安装，请先安装 pip"
    echo "⚠️  Windows 应用商店的 Python 需要通过微软商店安装完整版本"
    echo "⚠️  或者访问 https://www.python.org/downloads/ 下载安装程序"
    exit 1
fi

# 检查是否已安装 openClaw
PYTHON_CMD="python3"
if ! command -v python3 &> /dev/null; then
    PYTHON_CMD="python"
fi

if $PYTHON_CMD -c "import openclaw2" 2>/dev/null; then
    echo "✅ openClaw 已安装"
    # 检查版本
    # 检查版本
    VERSION=""
    if [ "$PIP_CMD" = "pip3" ] || [ "$PIP_CMD" = "pip" ]; then
        VERSION=$($PIP_CMD list | grep -E "openclaw" | awk '{print $2}')
    elif [[ "$PIP_CMD" == *"python"* && "$PIP_CMD" == *"pip"* ]]; then
        VERSION=$($PIP_CMD list | grep -E "openclaw" | awk '{print $2}')
    fi
    echo "   版本: $VERSION"
    exit 0
fi

echo "📦 开始安装 openClaw"

echo "执行命令: $PIP_CMD install openclaw"
$PIP_CMD install openclaw

# 验证安装
if $PYTHON_CMD -c "import openclaw2" 2>/dev/null; then
    echo "✅ openClaw 安装成功"
    VERSION=$($PIP_CMD list | grep -E "openclaw" | awk '{print $2}')
    echo "   版本: $VERSION"
else
    echo "❌ openClaw 安装失败"
    exit 1
fi

echo ""
echo "📚 使用说明:"
echo "   - 导入: from openclaw2 import OpenClaw"
echo "   - 创建客户端: client = OpenClaw.remote(api_key=\"your_api_key\")"
echo "   - 需要 CMDOP API 密钥"
echo ""
echo "🎯 更多信息:"
echo "   - 官方文档: https://cmdop.com/docs/sdk/python/"
echo "   - GitHub: https://github.com/commandoperator/cmdop-sdk-python"
