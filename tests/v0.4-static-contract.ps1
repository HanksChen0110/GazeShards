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

$expectedAssets = @(
  "assets/card_back.png",
  "assets/thefool_character.png",
  "assets/justice_character.png",
  "assets/thehangedman_character.png",
  "assets/sun_character.png",
  "assets/themagician_character.png",
  "assets/thehermit_character.png",
  "assets/star__character.png",
  "assets/moon_character.png"
)

foreach ($asset in $expectedAssets) {
  Assert-Contains ([regex]::Escape($asset)) "Missing tarot asset mapping: $asset"
}

Assert-Contains "backImageSrc\s*:" "TarotCardManager should define a shared backImageSrc."
Assert-Contains "preloadTarotAssets\s*\(" "Tarot assets should be preloaded without blocking startup."
Assert-Contains "cardState\s*:\s*`"faceDown`"" "Cards should begin face down."
Assert-Contains "faceDown\s*\|\|\s*revealing\s*\|\|\s*revealed\s*\|\|\s*summoned|faceDown \| revealing \| revealed \| summoned" "Card states should document the V0.4 reveal lifecycle."
Assert-Contains "const\s+RitualState\s*=" "RitualState should track shard-to-card ritual state."
Assert-Contains "const\s+CardRevealController\s*=" "CardRevealController should coordinate shard hover reveal logic."
Assert-Contains "getGrabbedShard\s*\(" "FaceShardManager should expose a read-only grabbed shard snapshot."
Assert-Contains "startReveal\s*\(" "TarotCardManager should expose startReveal for the reveal controller."
Assert-Contains "drawImageContain\s*\(" "Tarot artwork should be drawn with contain semantics."
Assert-Contains "is-opening" "Start overlay should use a transparent cloth opening state."

Write-Host "V0.4 static contract checks passed."
