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

function Assert-NotContains {
  param(
    [string] $Pattern,
    [string] $Message
  )

  if ($html -match $Pattern) {
    throw $Message
  }
}

Assert-Contains 'V0\.6' 'V0.6 stage marker should be present.'
Assert-Contains '\u8be1\u79d8\u4e4b\u955c' 'Current visible product name should be updated to the new product name.'
Assert-NotContains '<h1>\u7075\u89c6\u6863\u6848\u9986</h1>' 'Start overlay should no longer use the old product name.'
Assert-Contains 'experiencePhase\s*:\s*"curtain"' 'AppState should start in curtain phase.'
Assert-Contains 'curtain\s*\|\s*shardRitual\s*\|\s*revealed\s*\|\s*foolEnding' 'Experience phase lifecycle should be documented.'

Assert-Contains 'CurtainRevealManager' 'CurtainRevealManager should control the transparent membrane.'
Assert-Contains 'revealDistanceRatio\s*:\s*0\.18' 'Curtain reveal distance ratio should be configured.'
Assert-Contains 'CURTAIN_REVEALED' 'Curtain reveal should dispatch or record CURTAIN_REVEALED.'

Assert-Contains 'TriggerHintPanel' 'TriggerHintPanel should manage the upper-left hint.'
Assert-Contains 'triggerHintPanel' 'Hint panel DOM should exist.'
Assert-Contains 'curtainHint' 'Hint copy should expose a curtain guidance marker.'
Assert-Contains '\u795e\u79d8\u5f69\u86cb' 'Hint panel should name the hidden Fool path as the mystery easter egg.'
Assert-Contains '\u4e09\u6b21\u7728\u773c\uff1a\u91cd\u6392\u788e\u7247' 'Hint panel should explain that shard reflow takes three blinks.'
Assert-Contains '\u6325\u624b\uff1a\u5c55\u5f00\u724c\u8fd4\u56de\u80cc\u9762' 'Hint panel should explain that waving returns a revealed card to its back.'

Assert-Contains 'RippleManager' 'RippleManager should render spirit membrane ripples.'
Assert-Contains 'RippleManager\.emit' 'Pointer or pinch movement should emit ripples.'

Assert-Contains 'ShardLabelRenderer' 'ShardLabelRenderer should draw region labels.'
Assert-Contains 'maxVisibleDesktop\s*:\s*7' 'Desktop shard count should be capped at 7.'
Assert-Contains 'maxVisibleMobile\s*:\s*5' 'Mobile shard count should be capped at 5.'
Assert-Contains 'allowDecorativeShards\s*:\s*false' 'Decorative non-interactive shards should be disabled.'
Assert-Contains 'canTriggerCard\s*:\s*true' 'Visible shards should be card-trigger capable.'
Assert-Contains 'returnForce\s*:' 'Stable shard return force should be configured.'
Assert-Contains 'reflowStableLayout' 'Blink should reflow stable shard layout.'
Assert-Contains 'ShardBlinkReflowController' 'Shard reflow should be gated by a dedicated blink combo controller.'
Assert-Contains 'shardReflowBlinkCount' 'AppState should expose the separate three-blink shard reflow count.'
Assert-Contains 'buildRegularShardLayout' 'Face shards should use a regular reference-style spatial layout.'
Assert-Contains 'FaceShardManager\.reflowStableLayout\("tripleBlink"\)' 'Shard reflow should occur only after the gated triple-blink path.'

$blinkDetectorMatch = [regex]::Match($html, 'const\s+BlinkDetector\s*=\s*\{(?<body>[\s\S]*?)computeEyeOpenRatio')
if (!$blinkDetectorMatch.Success) {
  throw 'BlinkDetector body should be present for blink contract checks.'
}
if ($blinkDetectorMatch.Groups['body'].Value -match 'FaceShardManager\.reflowStableLayout') {
  throw 'A single valid blink should not directly reflow face shards.'
}

Assert-Contains 'registerCardTap' 'Fool fallback should support card-area triple tap.'
Assert-Contains 'fallbackTapCount' 'Fool fallback tap state should be tracked.'
Assert-Contains 'returnRevealedCardToBack' 'Open-palm/wave behavior should be able to return a revealed ordinary card to its back.'
Assert-Contains '\u666e\u901a\u5c55\u5f00\u724c\u5df2\u8fd4\u56de\u80cc\u9762' 'Wave-back behavior should provide a visible toast.'

Assert-Contains 'normalCardWidthRatioDesktop\s*:\s*0\.18' 'Normal desktop card size should be enlarged.'
Assert-Contains 'normalCardWidthRatioMobile\s*:\s*0\.28' 'Normal mobile card size should be enlarged.'

Assert-Contains 'DebugPanelController' 'DebugPanelController should provide stable debug panel hiding.'
Assert-Contains 'debugCloseBtn' 'Debug panel should include an internal close button.'
Assert-Contains 'ControlDockController' 'ControlDockController should protect bottom controls layout.'

Write-Host 'V0.6 static contract checks passed.'
