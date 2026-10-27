#!/usr/bin/env bash
# 用法: ./install.sh [--project]   預設裝到 ~/.claude/skills，--project 裝到 ./.claude/skills
set -euo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dest="$HOME/.claude/skills"
[ "${1:-}" = "--project" ] && dest="$PWD/.claude/skills"
mkdir -p "$dest"
for s in rdq grilling; do
  rm -rf "$dest/$s"
  cp -r "$here/skills/$s" "$dest/$s"
  echo "已安裝 $s -> $dest/$s"
done
echo "完成。請重啟 Claude Code，之後可用 /rdq 與 /grilling。"
