# Stage 8 Art Upgrade Report

## Goal

Upgrade GazeShards V0.3 into a stronger visual system: fixed top eye preview, square live-camera shards, grayscale blurred camera background, clear shard crops, colored tarot cards, open-palm card switching, and a three-blink Fool-card ending.

## Completed

- [x] Updated `CLAUDE.md` so Stage 8 is the V0.3 art upgrade and transparent cloth is deferred.
- [x] Added `CameraStylePipeline` for grayscale clear source crops and blurred grayscale camera background.
- [x] Added a grayscale settings toggle.
- [x] Added fixed `TopEyePreview` overlay that uses latest eye crops and does not move with shards.
- [x] Changed eye slices and face shards to render as square interactive fragments.
- [x] Expanded face shard regions across eyes, brows, nose, cheeks, mouth, forehead, and small face areas.
- [x] Added `TarotCardManager` with 8 colored procedural tarot cards.
- [x] Added `OpenPalmDetector` path so an open palm switches to the next card with cooldown.
- [x] Added three-blink combo logic that summons The Fool and enters the end state.
- [x] Preserved mouse/touch fallback and pinch routing for eye and face shards.

## Manual Test

- Browser: Chrome headless via DevTools Protocol
- URL: `http://localhost:5173/index.html`
- Camera: Chrome fake media device
- Screenshot evidence:
  - `G:\AI_products\GazeShards\.tmp\stage8-verified-desktop.png`
  - `G:\AI_products\GazeShards\.tmp\stage8-verified-mobile.png`

Checked:
- Initial page renders without blocking syntax errors.
- Start flow reaches `phase: running` without waiting for MediaPipe CDN completion.
- Render layers include `camera`, `face-shards`, `slices`, `tarot`, and `top-eye`.
- Canvas pixel sample is nonblank after start.
- Headless fake-camera path reaches `cameraReady: true` and `inputMode: camera`.
- Synthetic face landmarks create 14 face shards.
- Top eye preview receives a stable source rectangle after face landmarks are available.
- Face shards and source crops are square.
- Grayscale toggle changes `AppState.grayscaleEnabled` from `true` to `false` and updates button text.
- Open-palm trigger switches current card from `fool` to `justice`.
- Three blink registrations summon `fool`, set `gameEnded: true`, and set blink combo to `3`.
- 15-second post-summon stability held at 60 FPS in headless fake-camera verification.
- Mobile 390 x 844 smoke test reached `phase: running`, stayed above 50 FPS, and kept debug panel separate from controls.
- Cache-busting browser smoke test reported no runtime exceptions or app errors.

## Bugs Found

1. `startExperience()` waited for MediaPipe model loading before entering `running`, so slow CDN loading could leave the product stuck in `loading`.
2. Clear camera source was redrawn more than necessary in the same frame, and the end state could drop FPS sharply.
3. Automated validation needed a stable `TopEyePreview.sourceRect` state.
4. Mobile debug panel could overlap the control panel.

## Fixes Applied

1. Changed model loading to run in the background after the camera path starts. The app now enters `running` first and keeps mouse/touch/camera fallback playable while hand and face models load.
2. Added per-frame clear-source caching in `CameraStylePipeline`.
3. Reduced expensive camera blur in low-performance and end states.
4. Exposed `TopEyePreview.sourceRect` alongside `lastRect`.
5. Added mobile debug panel max-height and scrolling so it does not cover controls.

## Remaining Risks

1. Real hand-open detection and real blink timing still need a live-camera spot check because automated verification used fake camera and synthetic landmarks.
2. Tarot cards are procedural placeholders until generated image assets are added from the prompt pack.
3. The top eye preview intentionally shows a placeholder until face landmarks are available.

## Decision

- [x] Pass, Stage 8 complete for code-level MVP and headless smoke verification
- [ ] Blocked, must fix before continuing
