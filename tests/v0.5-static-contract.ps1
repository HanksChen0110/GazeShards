$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$indexPath = Join-Path $root "index.html"
$html = Get-Content -LiteralPath $indexPath -Raw -Encoding UTF8

function Assert-Contains {
  param(
    [string] $Pattern,
    [string] $Message
  )

  if ($html -notmatch $Pattern) {
    throw $Message
  }
}

Assert-Contains "V0\.[56]" "V0.5/V0.6 stage marker should be present."
Assert-Contains "spiritArchive" "V0.5 spirit archive copy/state marker should be present."

Assert-Contains "const\s+AudioManager\s*=" "AudioManager should manage the single looping BGM instance."
Assert-Contains "assets/Harry_Potter_-_Theme_Song_Hedwig_s_Theme_\(mp3\.pm\)\.mp3" "BGM asset path should be wired by relative path."
Assert-Contains "soundToggleBtn" "A small sound toggle button should be present."
Assert-Contains "AudioManager\.start\(\)" "BGM should start from the user start click path."

Assert-Contains "foolCard\s*:" "The Fool should be represented as a separate hidden card object."
Assert-Contains "FoolEasterEgg" "FoolEasterEgg controller should gate the hidden blink path."
Assert-Contains "hasRevealedArchive" "Fool trigger should require a completed ordinary archive reveal."

$tarotCardsMatch = [regex]::Match($html, "cards\s*:\s*\[(?<cards>[\s\S]*?)\]\s*,\s*foolCard")
if (!$tarotCardsMatch.Success) {
  throw "TarotCardManager.cards should be followed by a separate foolCard."
}
if ($tarotCardsMatch.Groups["cards"].Value -match "thefool|THE FOOL") {
  throw "Ordinary tarot card pool must not include The Fool."
}

Assert-Contains "regionType" "Face shards should carry regionType evidence."
Assert-Contains "ArchiveVerdictManager" "V0.5 should render identity archive verdicts."
Assert-Contains "verdicts\s*:" "Card verdicts should be defined in code."
Assert-Contains "registerOrdinaryReveal" "Ordinary reveal should enable the hidden Fool path."
Assert-Contains "archiveReading" "Slot hover should expose an archive reading state."
Assert-Contains "archiveGenerated" "Reveal completion should expose an archive generated state."

Write-Host "V0.5 static contract checks passed."
