# LobsterAI Skills Repository

This directory contains a collection of skills for LobsterAI - 个人助理技能仓库.

## About

This repository contains a collection of skills designed for use with LobsterAI, a personal assistant agent. Each skill provides specialized capabilities and workflows for various tasks.

## Skills Structure

Each skill is organized in its own directory:

```
skills/
├── skill-name/
│   ├── SKILL.md (required)
│   │   ├── YAML frontmatter metadata
│   │   │   ├── name: (required)
│   │   │   └── description: (required)
│   │   └── Markdown instructions
│   └── scripts/ (optional)
│       ├── executable scripts
│       └── utility functions
```

## Available Skills

### env-installer

**Description**: 自动化检查和安装开发环境。使用该技能可以检查系统是否已安装指定环境（如nvm、Node.js、Python等），自动搜索安装方法，执行安装过程，并进行测试验证。适用于初始化开发环境、批量安装常用工具。

**Features**:
- ✅ 自动检查环境是否已安装
- ✅ 根据操作系统自动选择安装方法
- ✅ 支持 Windows、macOS、Linux 系统
- ✅ 安装后自动测试验证
- ✅ 详细的安装报告

**Supported Environments**:
- NVM (Node Version Manager)
- Node.js (LTS version)
- Python (latest stable version)
- Git
- openClaw (AI代理编排库)

## Usage

To use these skills with LobsterAI, follow these steps:

1. Ensure skills are in the correct directory: `C:\Users\Administrator\lobsterai\skills`
2. LobsterAI will automatically discover skills in this location
3. Use skills through LobsterAI's interface

## Contributing

Contributions are welcome! Here's how you can add new skills:

1. Create a new directory under `skills/` for your skill
2. Write a `SKILL.md` file with proper frontmatter and instructions
3. Add any necessary scripts or resources
4. Test your skill thoroughly

## License

MIT