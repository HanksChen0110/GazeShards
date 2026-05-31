$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$indexPath = Join-Path $root 'index.html'
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

Assert-Contains 'V0\.6' 'V0.6 stage marker should be present.'
Assert-Contains 'experiencePhase\s*:\s*"curtain"' 'AppState should start in curtain phase.'
Assert-Contains 'curtain\s*\|\s*shardRitual\s*\|\s*revealed\s*\|\s*foolEnding' 'Experience phase lifecycle should be documented.'

Assert-Contains 'CurtainRevealManager' 'CurtainRevealManager should control the transparent membrane.'
Assert-Contains 'revealDistanceRatio\s*:\s*0\.18' 'Curtain reveal distance ratio should be configured.'
Assert-Contains 'CURTAIN_REVEALED' 'Curtain reveal should dispatch or record CURTAIN_REVEALED.'

Assert-Contains 'TriggerHintPanel' 'TriggerHintPanel should manage the upper-left hint.'
Assert-Contains 'triggerHintPanel' 'Hint panel DOM should exist.'
Assert-Contains 'curtainHint' 'Hint copy should expose a curtain guidance marker.'

Assert-Contains 'RippleManager' 'RippleManager should render spirit membrane ripples.'
Assert-Contains 'RippleManager\.emit' 'Pointer or pinch movement should emit ripples.'

Assert-Contains 'ShardLabelRenderer' 'ShardLabelRenderer should draw region labels.'
Assert-Contains 'maxVisibleDesktop\s*:\s*7' 'Desktop shard count should be capped at 7.'
Assert-Contains 'maxVisibleMobile\s*:\s*5' 'Mobile shard count should be capped at 5.'
Assert-Contains 'allowDecorativeShards\s*:\s*false' 'Decorative non-interactive shards should be disabled.'
Assert-Contains 'canTriggerCard\s*:\s*true' 'Visible shards should be card-trigger capable.'
Assert-Contains 'returnForce\s*:' 'Stable shard return force should be configured.'
Assert-Contains 'reflowStableLayout' 'Blink should reflow stable shard layout.'

Assert-Contains 'registerCardTap' 'Fool fallback should support card-area triple tap.'
Assert-Contains 'fallbackTapCount' 'Fool fallback tap state should be tracked.'

Assert-Contains 'normalCardWidthRatioDesktop\s*:\s*0\.18' 'Normal desktop card size should be enlarged.'
Assert-Contains 'normalCardWidthRatioMobile\s*:\s*0\.28' 'Normal mobile card size should be enlarged.'

Assert-Contains 'DebugPanelController' 'DebugPanelController should provide stable debug panel hiding.'
Assert-Contains 'debugCloseBtn' 'Debug panel should include an internal close button.'
Assert-Contains 'ControlDockController' 'ControlDockController should protect bottom controls layout.'

Write-Host 'V0.6 static contract checks passed.'
