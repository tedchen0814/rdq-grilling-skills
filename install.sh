#!/usr/bin/env bash
# 用法: ./install.sh   一律裝到全域 ~/.claude/skills（不提供專案層選項）
set -euo pipefail
[ $# -eq 0 ] || { echo "install.sh 不接受參數（一律裝到全域 ~/.claude/skills）：$*" >&2; exit 2; }
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dest="$HOME/.claude/skills"
mkdir -p "$dest"
for s in rdq grilling; do
  rm -rf "$dest/$s"
  cp -r "$here/skills/$s" "$dest/$s"
  echo "已安裝 $s -> $dest/$s"
done
echo "完成。請重啟 Claude Code，之後可用 /rdq 與 /grilling。"
