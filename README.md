# Homebrew Backup

备份和恢复 macOS Homebrew 环境。

## 备份

```bash
./backup.sh
```

## 恢复（新机器）

```bash
# 1. 先安装 Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. 克隆仓库
git clone <your-repo-url> ~/personal/homebrew

# 3. 恢复所有软件
cd ~/personal/homebrew
./restore.sh
```
