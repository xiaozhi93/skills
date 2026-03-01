#!/bin/bash

echo "=== 环境测试 ==="

echo ""
echo "📦 Node.js 测试"
if command -v node &> /dev/null; then
    node_version=$(node --version)
    echo "✅ Node.js 版本: $node_version"
    node -e "console.log('Hello from Node.js')"
else
    echo "❌ Node.js 未安装"
fi

echo ""
echo "📦 npm 测试"
if command -v npm &> /dev/null; then
    npm_version=$(npm --version)
    echo "✅ npm 版本: $npm_version"
else
    echo "❌ npm 未安装"
fi

echo ""
echo "📦 Python 测试"
if command -v python3 &> /dev/null; then
    python_version=$(python3 --version)
    echo "✅ Python 版本: $python_version"
    python3 -c "print('Hello from Python')"
elif command -v python &> /dev/null; then
    python_version=$(python --version)
    echo "✅ Python 版本: $python_version"
    python -c "print('Hello from Python')"
else
    echo "❌ Python 未安装"
fi

echo ""
echo "📦 Git 测试"
if command -v git &> /dev/null; then
    git_version=$(git --version)
    echo "✅ Git 版本: $git_version"
else
    echo "❌ Git 未安装"
fi

echo ""
echo "=== 测试完成 ==="
