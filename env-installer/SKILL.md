---
name: env-installer
description: 自动化检查和安装开发环境。使用该技能可以检查系统是否已安装指定环境（如nvm、Node.js、Python等），自动搜索安装方法，执行安装过程，并进行测试验证。适用于初始化开发环境、批量安装常用工具。
license: MIT
official: false
---

# 环境安装技能

该技能用于自动化检查和安装开发环境。它会：
1. 检查系统是否已安装指定的开发环境
2. 如未安装，自动搜索网络上的安装方法
3. 执行安装过程
4. 安装完成后进行测试验证
5. 提供安装结果总结

## 支持的环境

### 默认安装环境
- **NVM** - Node版本管理器
- **Node.js** - 稳定版本（LTS）
- **Python** - 最新稳定版本
- **openClaw** - AI代理编排库（Python）

### 扩展支持
- Git
- Docker
- Visual Studio Code
- 其他开发工具

## 使用方法

### 检查环境
1. 使用Bash工具检查环境是否已安装
2. 支持的检查命令：
   - `nvm --version` - 检查NVM
   - `node --version` - 检查Node.js
   - `python --version` 或 `python3 --version` - 检查Python
   - `git --version` - 检查Git
   - `pip list | grep openclaw` - 检查openClaw

### 安装流程

#### Windows系统
1. NVM安装：使用winget或chocolatey包管理器
2. Node.js安装：通过nvm安装稳定版本
3. Python安装：使用winget或官方安装包

#### macOS系统
1. 使用Homebrew包管理器
2. 安装命令：`brew install nvm python git`

#### Linux系统
1. 使用apt、yum或dnf包管理器
2. 或使用官方安装脚本

### 测试验证
安装完成后，执行简单的测试命令：
- Node.js：`node -e "console.log('Node.js is working')"`
- Python：`python -c "print('Python is working')"`
- Git：`git --version`
- openClaw：`python -c "from openclaw2 import OpenClaw; print('openClaw is working')"`

## 脚本资源

### check_env.sh
检查系统已安装的开发环境版本

### install_nvm.sh
安装NVM（Node版本管理器）

### install_node.sh
通过NVM安装稳定版本的Node.js

### install_python.sh
安装Python环境

### install_openclaw.sh
安装openClaw AI代理编排库

### test_env.sh
测试已安装的环境

## 执行步骤

1. 运行环境检查脚本
2. 分析检查结果
3. 对未安装的环境执行安装脚本
4. 执行测试脚本验证安装
5. 生成安装报告

## 注意事项

- 某些安装可能需要管理员权限
- Windows系统可能需要重启终端或计算机
- 网络连接问题可能导致安装失败
- 安装过程中可能需要用户确认某些选项
- **Windows 应用商店的 Python 问题**：
  - 如果使用 Windows 应用商店的 Python，可能会遇到命令无法执行的问题
  - 建议访问 https://www.python.org/downloads/ 下载官方 Python 安装程序
  - 确保在安装时勾选 "Add Python to PATH" 选项
  - 安装后重新打开终端

## 常见问题

### 解决 pip 安装失败

如果遇到 `pip: command not found` 错误：

1. 确保 Python 已正确安装并添加到 PATH
2. 使用 `python -m pip` 代替直接使用 `pip`
3. 在 Windows 上可能需要重新安装 Python 并勾选 "Add to PATH"
4. 或者手动配置环境变量
