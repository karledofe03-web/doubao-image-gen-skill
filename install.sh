#!/bin/bash
# 🦞 豆包生图技能-龙虾 一键安装脚本
# 使用方法: curl -fsSL https://raw.githubusercontent.com/karledofe03-web/doubao-image-gen-skill/main/install.sh | bash

set -e

echo "🦞 正在安装豆包生图技能-龙虾..."
echo ""

# 配置
SKILL_NAME="doubao-image-gen"
INSTALL_DIR="$HOME/.agents/$SKILL_NAME"
REPO_URL="https://github.com/karledofe03-web/doubao-image-gen-skill.git"

# 检查依赖
echo "📋 检查依赖..."
if ! command -v curl &> /dev/null; then
    echo "❌ 请先安装 curl"
    echo "   macOS: brew install curl"
    echo "   Linux: apt-get install curl"
    exit 1
fi

if ! command -v jq &> /dev/null; then
    echo "⚠️  建议安装 jq 以获得更好体验"
    echo "   macOS: brew install jq"
    echo "   Linux: apt-get install jq"
fi

# 创建安装目录
echo "📁 创建安装目录..."
mkdir -p "$INSTALL_DIR/scripts"

# 下载技能文件
echo "⬇️  下载技能文件..."
curl -fsSL "$REPO_URL/raw/main/SKILL.md" -o "$INSTALL_DIR/SKILL.md"
curl -fsSL "$REPO_URL/raw/main/scripts/doubao-generate.sh" -o "$INSTALL_DIR/scripts/doubao-generate.sh"
chmod +x "$INSTALL_DIR/scripts/doubao-generate.sh"

echo ""
echo "✅ 技能安装完成！"
echo ""
echo "📍 安装位置: $INSTALL_DIR"
echo ""
echo "🔧 下一步: 配置 API Key"
echo ""
echo "1. 访问 https://console.volcengine.com/ 获取 API Key"
echo "2. 在 ~/.openclaw/openclaw.json 中添加配置:"
echo ""
echo '   "skills": {'
echo '     "doubao-image-gen": {'
echo '       "enabled": true,'
echo '       "env": {'
echo '         "DOUBAO_API_KEY": "your-api-key-here"'
echo '       }'
echo '     }'
echo '   }'
echo ""
echo "🎨 使用方法:"
echo "   ~/.agents/doubao-image-gen/scripts/doubao-generate.sh \\"
echo '     --prompt "一只可爱的猫咪" \\"
echo '     --output ~/images/cat.png'
echo ""
echo "🦞 安装完成！快去试试吧！"
