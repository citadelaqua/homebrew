#!/bin/bash
# 备份当前 Homebrew 环境到 brewfile
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BREWFILE="$SCRIPT_DIR/brewfile"

echo "📦 正在导出 Homebrew 配置..."
brew bundle dump --describe --force --file="$BREWFILE"

echo "✅ 备份完成: $BREWFILE"

# 如果在 git 仓库中，自动提交
if git -C "$SCRIPT_DIR" rev-parse --is-inside-work-tree &>/dev/null; then
    cd "$SCRIPT_DIR"
    if ! git diff --quiet "$BREWFILE" 2>/dev/null || ! git ls-files --error-unmatch "$BREWFILE" &>/dev/null; then
        git add brewfile
        git commit -m "update brewfile $(date +%Y-%m-%d)"
        echo "📝 已自动提交变更"
    else
        echo "📝 brewfile 无变化，跳过提交"
    fi
fi
