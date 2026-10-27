# 用法: .\install.ps1 [-Project]   預設裝到 ~\.claude\skills，-Project 裝到 .\.claude\skills
param([switch]$Project)
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$dest = if ($Project) { Join-Path (Get-Location) '.claude\skills' } else { Join-Path $HOME '.claude\skills' }
New-Item -ItemType Directory -Force $dest | Out-Null
foreach ($s in 'rdq', 'grilling') {
  $target = Join-Path $dest $s
  if (Test-Path $target) { Remove-Item -Recurse -Force $target }
  Copy-Item -Recurse (Join-Path $here "skills\$s") $target
  Write-Host "已安裝 $s -> $target"
}
Write-Host '完成。請重啟 Claude Code，之後可用 /rdq 與 /grilling。'
