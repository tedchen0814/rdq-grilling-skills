# 用法: .\install.ps1 [-Project]   預設裝到 ~\.claude\skills，-Project 裝到 .\.claude\skills
# 也可用 -ProjectPath <資料夾> 指定專案資料夾（會自動視為 -Project）
param([switch]$Project, [string]$ProjectPath = '')
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
if ($ProjectPath) { $Project = $true }
if ($Project) {
  if (-not $ProjectPath) { $ProjectPath = (Get-Location).Path }
  if (-not (Test-Path -LiteralPath $ProjectPath -PathType Container)) { Write-Host "找不到專案資料夾：$ProjectPath" -ForegroundColor Red; exit 2 }
  $dest = Join-Path (Resolve-Path -LiteralPath $ProjectPath).Path '.claude\skills'
} else {
  $dest = Join-Path $HOME '.claude\skills'
  Write-Host '提醒：這 2 個 skill 會裝到「全域」，每個專案的每個對話開頭都會載入它們的名稱與說明（占用上下文）。' -ForegroundColor Yellow
  Write-Host '      若只在特定專案用，請 Ctrl+C 中止，改用：.\install.ps1 -ProjectPath <專案資料夾>' -ForegroundColor Yellow
}
New-Item -ItemType Directory -Force $dest | Out-Null
foreach ($s in 'rdq', 'grilling') {
  $target = Join-Path $dest $s
  if (Test-Path $target) { Remove-Item -Recurse -Force $target }
  Copy-Item -Recurse (Join-Path $here "skills\$s") $target
  Write-Host "已安裝 $s -> $target"
}
if ($Project) {
  Write-Host "已裝到這個專案：$dest（只有在該專案資料夾開啟 Claude Code 才會載入；公開 git repo 請把 .claude/ 加進 .git/info/exclude）"
} else {
  Write-Host '已裝到全域。之後想只留在某個專案，可把這 2 個資料夾搬到該專案的 .claude\skills。'
}
Write-Host '完成。請重啟 Claude Code，之後可用 /rdq 與 /grilling。'
