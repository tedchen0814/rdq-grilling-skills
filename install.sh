#!/usr/bin/env bash
# 用法: ./install.sh [--project]   預設裝到 ~/.claude/skills，--project 裝到 ./.claude/skills
set -euo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project=0; dest="$HOME/.claude/skills"
if [ "${1:-}" = "--project" ]; then
  # 可選：--project <專案資料夾>（沒給就用目前資料夾）
  proj="${2:-$PWD}"
  [ -d "$proj" ] || { echo "找不到專案資料夾：$proj" >&2; exit 2; }
  dest="$(cd "$proj" && pwd)/.claude/skills"; project=1
else
  echo "提醒：這 2 個 skill 會裝到「全域」，每個專案的每個對話開頭都會載入它們的名稱與說明（占用上下文）。"
  echo "      若只在特定專案用，請 Ctrl+C 中止，改用：./install.sh --project <專案資料夾>"
fi
mkdir -p "$dest"
for s in rdq grilling; do
  rm -rf "$dest/$s"
  cp -r "$here/skills/$s" "$dest/$s"
  echo "已安裝 $s -> $dest/$s"
done
if [ "$project" = 1 ]; then
  echo "已裝到這個專案：$dest（只有在該專案資料夾開啟 Claude Code 才會載入；公開 git repo 請把 .claude/ 加進 .git/info/exclude）"
else
  echo "已裝到全域。之後想只留在某個專案，可把這 2 個資料夾搬到該專案的 .claude/skills。"
fi
echo "完成。請重啟 Claude Code，之後可用 /rdq 與 /grilling。"
