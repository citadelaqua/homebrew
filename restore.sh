#!/bin/bash
# 从 brewfile 恢复 Homebrew 环境
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BREWFILE="$SCRIPT_DIR/brewfile"

if [ ! -f "$BREWFILE" ]; then
    echo "❌ 找不到 brewfile: $BREWFILE"
    exit 1
fi

# 检查 Homebrew 是否已安装
if ! command -v brew &>/dev/null; then
    echo "🍺 Homebrew 未安装，正在安装..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "📦 正在从 brewfile 恢复..."
brew bundle --file="$BREWFILE"
echo "✅ 恢复完成！"
