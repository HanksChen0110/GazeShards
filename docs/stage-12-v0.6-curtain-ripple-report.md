# GazeShards V0.6 Upgrade Verification

Date: 2026-05-31
Branch: codex/v0.4-tarot-reveal

## Scope

- Added transparent curtain entry stage.
- Added spirit-vision ripple feedback on pointer and pinch movement.
- Repaired interaction staging so face shards only appear after the curtain is revealed.
- Reduced shard count and stabilized shard motion for a clearer ritual surface.
- Added trigger hint panel controls and a closeable debug panel.
- Added Fool fallback trigger by repeated taps after a normal archive reveal.

## Files

- `index.html`
- `tests/v0.6-static-contract.ps1`
- `tests/v0.5-static-contract.ps1`

## Verification

- V0.6 static contract: passed.
- V0.5 static contract: passed with version marker compatibility updated for V0.6.
- V0.4 static contract: passed.
- Browser desktop check: curtain stage starts with no face shards, drag opens curtain, then shard ritual renders 7 shards.
- Browser mobile check: curtain stage renders correctly, controls stay visible, debug panel close button hides the panel.

## Browser Evidence

- `docs/stage-12-v0.6-curtain-desktop.png`
- `docs/stage-12-v0.6-shards-desktop.png`
- `docs/stage-12-v0.6-mobile.png`

## Notes

The V0.6 browser pass focused on the new curtain, ripple, mobile layout, and debug/hint controls. Existing static contracts continue to guard the tarot reveal and prior interaction contracts.
