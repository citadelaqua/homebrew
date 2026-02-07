# Homebrew Backup

备份和恢复 macOS Homebrew 环境。

## 备份

安装或卸载软件后，运行备份脚本更新 brewfile 并自动提交：

```bash
./backup.sh
```

## 恢复（新机器）

一条命令搞定，脚本会自动完成以下步骤：
1. 安装 Xcode Command Line Tools（提供 git）
2. 安装 Homebrew
3. 克隆本仓库
4. 从 brewfile 恢复所有软件

```bash
curl -fsSL https://raw.githubusercontent.com/schip/homebrew/main/setup.sh | bash
```

也可以手动克隆后运行：

```bash
git clone https://github.com/citadelaqua/homebrew.git ~/personal/homebrew
cd ~/personal/homebrew
./restore.sh
```

## 文件说明

| 文件 | 用途 |
|------|------|
| `brewfile` | Homebrew 软件清单 |
| `backup.sh` | 导出当前环境并自动提交 |
| `restore.sh` | 从 brewfile 恢复软件（本地使用） |
| `setup.sh` | 新机器一键恢复（含环境安装） |
