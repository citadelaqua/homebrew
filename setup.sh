#!/bin/bash
# 一键恢复 Homebrew 环境（适用于全新 macOS 机器）
# 用法：curl -fsSL <raw-url>/setup.sh | bash
set -e

REPO_URL="https://github.com/schip/homebrew.git"  # ← 改成你的仓库地址
INSTALL_DIR="$HOME/personal/homebrew"

echo "========================================="
echo "  macOS Homebrew 环境一键恢复"
echo "========================================="
echo ""

# ---- 1. 安装 Xcode Command Line Tools（提供 git）----
if ! xcode-select -p &>/dev/null; then
    echo "[1/4] 🔧 正在安装 Xcode Command Line Tools（包含 git）..."
    xcode-select --install
    echo "⏳ 请在弹窗中点击「安装」，等待安装完成后重新运行此脚本"
    exit 0
else
    echo "[1/4] ✅ Xcode Command Line Tools 已安装"
fi

# ---- 2. 安装 Homebrew ----
if ! command -v brew &>/dev/null; then
    echo "[2/4] 🍺 正在安装 Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Apple Silicon 需要手动加 PATH
    if [ -f /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "[2/4] ✅ Homebrew 已安装"
fi

# ---- 3. 克隆仓库 ----
if [ -d "$INSTALL_DIR/.git" ]; then
    echo "[3/4] 📥 仓库已存在，正在拉取最新配置..."
    git -C "$INSTALL_DIR" pull
else
    echo "[3/4] 📥 正在克隆配置仓库..."
    mkdir -p "$(dirname "$INSTALL_DIR")"
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

# ---- 4. 恢复所有软件 ----
BREWFILE="$INSTALL_DIR/brewfile"
if [ ! -f "$BREWFILE" ]; then
    echo "❌ 找不到 brewfile: $BREWFILE"
    exit 1
fi

echo "[4/4] 📦 正在从 brewfile 恢复所有软件..."
brew bundle --file="$BREWFILE"

echo ""
echo "========================================="
echo "  ✅ 恢复完成！"
echo "========================================="
