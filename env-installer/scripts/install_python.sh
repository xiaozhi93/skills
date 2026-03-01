#!/bin/bash

echo "=== 安装 Python ==="

# 检查是否已安装
if command -v python3 &> /dev/null; then
    # 检查是否为 Windows 应用商店版本
    if [ -f "/c/Users/Administrator/AppData/Local/Microsoft/WindowsApps/python3.exe" ]; then
        echo "⚠️  检测到 Windows 应用商店版本的 Python，需要先卸载"
        "$(dirname "$0")/uninstall_python.sh"
    else
        echo "✅ Python3 已安装: $(python3 --version)"
        exit 0
    fi
elif command -v python &> /dev/null; then
    # 检查是否为 Windows 应用商店版本
    if [ -f "/c/Users/Administrator/AppData/Local/Microsoft/WindowsApps/python.exe" ]; then
        echo "⚠️  检测到 Windows 应用商店版本的 Python，需要先卸载"
        "$(dirname "$0")/uninstall_python.sh"
    else
        echo "✅ Python 已安装: $(python --version)"
        exit 0
    fi
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
            echo "📦 使用 winget 安装 Python 3.12 (winget源)"
            echo "⚠️  正在配置 winget 源..."
            # 检查并移除 msstore 源（避免证书问题）
            if winget source list | grep -i "msstore" > /dev/null 2>&1; then
                echo "⚠️  检测到 msstore 源，正在禁用..."
                winget source remove --name msstore > /dev/null 2>&1
            fi

            echo "📥 正在安装 Python 3.12..."
            # 使用管理员权限安装 Python
            if ! powershell -Command "Start-Process winget -ArgumentList 'install','--id','Python.Python.3.12','--source','winget','--force' -Verb RunAs -Wait"; then
                echo "❌ winget 安装失败，尝试直接下载安装"
                echo "📥 正在从官方网站下载 Python..."
                # 如果 winget 失败，直接使用官方下载
                if ! powershell -Command "
                    \$pythonUrl = 'https://www.python.org/ftp/python/3.12.10/python-3.12.10-amd64.exe'
                    \$pythonInstaller = 'python-3.12.10-amd64.exe'
                    Invoke-WebRequest -Uri \$pythonUrl -OutFile \$pythonInstaller -UseBasicParsing | Out-Null
                    Write-Host '✅ 下载成功'
                    Write-Host '📦 正在安装 Python...'
                    Start-Process -FilePath \$pythonInstaller -ArgumentList '/quiet', 'PrependPath=1' -Wait
                    Write-Host '✅ 安装成功'
                    Remove-Item \$pythonInstaller -Force
                "; then
                    echo "❌ 自动安装失败，请手动下载"
                    echo "🔗 下载地址: https://www.python.org/downloads/"
                    echo "⚠️  手动安装时请确保勾选 'Add Python to PATH'"
                    exit 1
                fi
            fi
        else
            echo "❌ winget 不可用，尝试直接下载安装"
            echo "📥 正在从官方网站下载 Python..."
            if ! powershell -Command "
                \$pythonUrl = 'https://www.python.org/ftp/python/3.12.10/python-3.12.10-amd64.exe'
                \$pythonInstaller = 'python-3.12.10-amd64.exe'
                Invoke-WebRequest -Uri \$pythonUrl -OutFile \$pythonInstaller -UseBasicParsing | Out-Null
                Write-Host '✅ 下载成功'
                Write-Host '📦 正在安装 Python...'
                Start-Process -FilePath \$pythonInstaller -ArgumentList '/quiet', 'PrependPath=1' -Wait
                Write-Host '✅ 安装成功'
                Remove-Item \$pythonInstaller -Force
            "; then
                echo "❌ 自动安装失败，请手动下载"
                echo "🔗 下载地址: https://www.python.org/downloads/"
                echo "⚠️  手动安装时请确保勾选 'Add Python to PATH'"
                exit 1
            fi
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
