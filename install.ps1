# 用法: .\install.ps1   一律裝到全域 ~\.claude\skills（不提供專案層選項）
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$dest = Join-Path $HOME '.claude\skills'
New-Item -ItemType Directory -Force $dest | Out-Null
foreach ($s in 'rdq', 'grilling') {
  $target = Join-Path $dest $s
  if (Test-Path $target) { Remove-Item -Recurse -Force $target }
  Copy-Item -Recurse (Join-Path $here "skills\$s") $target
  Write-Host "已安裝 $s -> $target"
}
Write-Host '完成。請重啟 Claude Code，之後可用 /rdq 與 /grilling。'
