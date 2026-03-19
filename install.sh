#!/bin/bash
# DramaAdapt Skill 一键安装脚本
# 用法：./install.sh

set -e

SKILL_DIR="$HOME/.claude/skills/drama-adapt"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  DramaAdapt Skill 安装程序"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 检查 skill 源文件是否存在
if [ ! -f "$SCRIPT_DIR/skill/SKILL.md" ]; then
  echo "❌ 错误：找不到 skill/SKILL.md 文件"
  echo "   请确保在仓库根目录执行此脚本"
  exit 1
fi

# 创建目标目录
echo ""
echo "📁 创建 Skill 目录：$SKILL_DIR"
mkdir -p "$SKILL_DIR/references"

# 复制文件
echo "📋 复制 SKILL.md ..."
cp "$SCRIPT_DIR/skill/SKILL.md" "$SKILL_DIR/SKILL.md"

echo "📋 复制格式规范参考文件 ..."
cp "$SCRIPT_DIR/skill/references/script-format-guide.md" "$SKILL_DIR/references/script-format-guide.md"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ 安装完成！"
echo ""
echo "安装位置："
echo "  $SKILL_DIR/SKILL.md"
echo "  $SKILL_DIR/references/script-format-guide.md"
echo ""
echo "使用方法："
echo "  1. 新建一个文件夹，放入小说 .txt 文件"
echo "  2. 在该文件夹内启动 Claude Code："
echo "     cd my-novel && claude"
echo "  3. 运行：/drama-adapt"
echo ""
echo "查看完整示例：example/ 目录"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
