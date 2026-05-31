# Stage 7 Face Shards Report

## Goal

Extend the eye-slice MVP with V0.2 face shards while preserving Stage 5 core interaction and Stage 6 polish behavior.

## Completed

- [x] Added `FaceShard` class
- [x] Added `FaceShardManager`
- [x] Face shards are generated from face bounding box regions
- [x] Regions include forehead, nose, mouth, left/right cheeks, and smaller face rectangles
- [x] Face shards use live camera source rectangles when face tracking is available
- [x] Blink triggers face shard reassembly
- [x] Face proximity change can trigger scatter/reassemble
- [x] Pinch or pointer can grab a face shard
- [x] Open palm scatters face shards
- [x] Fist freezes face shards
- [x] Face shards render behind eye slices
- [x] Face shards participate in reset behavior
- [x] Debug panel shows face shard count, hand pose, and frozen state

## Manual Test

- Browser: Headless Chrome via Chrome DevTools Protocol
- URL: `http://localhost:5173/index.html`
- Camera: Chrome fake media device plus synthetic face landmarks
- Result: Pass

Checked:
- Synthetic face landmarks created 14 face shards.
- All 14 face shards received source rectangles from the face bounding box.
- Blink closed/open transition triggered `lastBlinkTime`, emitted 24 particles, and pulled shards back near home positions.
- Face proximity routing supports close scale pulse and far scatter.
- Open-palm synthetic landmarks triggered scatter velocity.
- Fist synthetic landmarks set `faceShardsFrozen: true` and stopped shard motion.
- A face shard could be grabbed, dragged, and released with velocity.
- Face shards rendered in the layer order `camera -> face-shards -> slices`.
- Reset cleared face shards and particles.
- 15-second stability smoke test stayed in `phase: running`, with no app errors and no browser exceptions.

## Bugs Found

- Open-palm scatter and fist freeze were not implemented in the first Stage 7 pass.
- Face proximity behavior needed a clearer close/far split.

## Fixes Applied

- Added `HandPoseDetector` and `OpenPalmDetector`.
- Routed open palm to face shard scatter.
- Routed fist to face shard freeze.
- Added close-face scale pulse and far-face scatter.
- Face shards were integrated into the same interaction routing as eye slices, so pinch and pointer fallback can target both layers.

## Remaining Risks

- Real face shard visual quality depends on live camera framing and lighting.
- Stage 7 was verified with synthetic face/hand landmarks and fake camera; real-user face movement and hand pose should be spot-checked before a public demo.

## Decision

- [x] Pass, Stage 7 complete
- [ ] Blocked, must fix before continuing
