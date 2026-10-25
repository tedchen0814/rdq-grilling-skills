# rdq-grilling-skills

一鍵安裝兩個 Claude Code skill：

| Skill | 用途 |
|---|---|
| `/rdq` | 動工前的需求訪談（四象限法），產出一頁需求規格卡，確認後才執行 |
| `/grilling` | 對計畫或想法做決策樹式拷問，一輪一輪問到共識（上游：Matt Pocock） |

## 安裝

**Windows (PowerShell)**
```powershell
git clone https://github.com/tedchen0814/rdq-grilling-skills.git ; cd rdq-grilling-skills ; .\install.ps1
```

**macOS / Linux / Git Bash**
```bash
git clone https://github.com/tedchen0814/rdq-grilling-skills.git && cd rdq-grilling-skills && ./install.sh
```

預設安裝到 `~/.claude/skills/`（全域）。只想裝在目前專案，加 `-Project`（PowerShell）或 `--project`（bash）。
重複執行會覆蓋舊版。安裝後重啟 Claude Code。

## 使用

- `/rdq` 或說「跑 RDQ」：先訪談，再出規格卡
- `/grilling` 或說「grill me」：被拷問你的方案

## 授權

兩個 skill 皆 MIT，詳見 `LICENSE`。
