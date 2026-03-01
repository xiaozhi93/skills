#!/bin/bash

echo "=== 卸载 Python ==="

# 检查是否为 Windows 系统
OS=$(uname -s)

if [[ "$OS" != "MINGW"* && "$OS" != "CYGWIN"* && "$OS" != "MSYS"* ]]; then
    echo "❌ 此脚本仅适用于 Windows 系统"
    exit 1
fi

# 检查 Windows 应用商店 Python 是否存在
if command -v python &> /dev/null || command -v python3 &> /dev/null; then
    echo "📦 检测到 Python 已安装"

    # 检查是否为 Windows 应用商店版本
    if [ -f "/c/Users/Administrator/AppData/Local/Microsoft/WindowsApps/python.exe" ] || [ -f "/c/Users/Administrator/AppData/Local/Microsoft/WindowsApps/python3.exe" ]; then
        echo "⚠️  检测到 Windows 应用商店版本的 Python"

        # 使用 winget 尝试卸载
        if command -v winget &> /dev/null; then
            echo "🔧 使用 winget 卸载 Windows 应用商店版本 Python"
            # 尝试找到已安装的 Python 包
            echo "📋 查找已安装的 Python 包..."
            winget list --name Python
            echo ""

            # 尝试卸载 Microsoft Store 版本的 Python
            # 首先尝试使用 winget 卸载
            if winget uninstall "Python" --exact 2>&1 >/dev/null; then
                echo "✅ 成功卸载 Windows 应用商店版本 Python"
            else
                echo "⚠️  winget 卸载失败，尝试使用 PowerShell 卸载"
                # 使用 PowerShell 从应用商店卸载
                powershell -Command "Get-AppxPackage *Python* | Remove-AppxPackage"
                if [ $? -eq 0 ]; then
                    echo "✅ 成功卸载 Windows 应用商店版本 Python"
                else
                    echo "⚠️  无法自动卸载，请手动从 Windows 设置中卸载"
                    echo "📌 手动卸载步骤:"
                    echo "1. 打开 Windows 设置 (Win + I)"
                    echo "2. 转到 \"应用\" -> \"应用和功能\""
                    echo "3. 搜索 \"Python\""
                    echo "4. 选择 Windows 应用商店版本的 Python 并点击卸载"
                    read -p "按回车键继续..."
                fi
            fi
        else
            echo "⚠️  winget 不可用，无法自动卸载"
            echo "📌 手动卸载步骤:"
            echo "1. 打开 Windows 设置 (Win + I)"
            echo "2. 转到 \"应用\" -> \"应用和功能\""
            echo "3. 搜索 \"Python\""
            echo "4. 选择 Windows 应用商店版本的 Python 并点击卸载"
            read -p "按回车键继续..."
        fi
    else
        echo "✅ 检测到非 Windows 应用商店版本的 Python"
    fi
else
    echo "✅ Python 未安装"
fi

# 清理可能的残留
echo ""
echo "🔄 清理可能的残留..."
# 删除可能的 WindowsApps 目录下的 Python 关联
if [ -d "/c/Users/Administrator/AppData/Local/Microsoft/WindowsApps" ]; then
    rm -f "/c/Users/Administrator/AppData/Local/Microsoft/WindowsApps/python.exe"
    rm -f "/c/Users/Administrator/AppData/Local/Microsoft/WindowsApps/python3.exe"
    rm -f "/c/Users/Administrator/AppData/Local/Microsoft/WindowsApps/pip.exe"
    rm -f "/c/Users/Administrator/AppData/Local/Microsoft/WindowsApps/pip3.exe"
fi

# 重新加载 PATH
echo ""
echo "✅ Python 卸载过程完成！"
echo "⚠️  可能需要重启终端才能完全生效"
