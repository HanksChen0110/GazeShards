# Stage 4 Report

## Goal

Connect face and eye tracking: FaceTracker, left/right eye rectangles, real eye crop source rectangles, blink detection, blink visual effect, and debug visualization.

## Completed

- [x] FaceTracker implemented
- [x] MediaPipe Tasks Vision Face Landmarker load path implemented
- [x] Face model failure keeps fallback usable
- [x] Left/right eye rectangles computed from landmarks
- [x] Eye slice source rectangles update from latest eye rects
- [x] BlinkDetector implemented
- [x] Blink cooldown implemented
- [x] Blink triggers visible slice effect
- [x] Debug panel shows face/blink state
- [x] Mouse/touch fallback and hand pinch path remain usable

## Manual Test

- Browser: Headless Chrome via Chrome DevTools Protocol
- Device: Windows desktop
- Camera: Chrome fake media device plus mock face landmarks
- Result: Pass

Checked:
- Stage 3 was re-verified before Stage 4 work: fake camera startup, `handReady: true`, mock `PINCH_DOWN / PINCH_DRAG / PINCH_UP`, and no page exceptions or resource logs.
- Mock open-face landmarks produced left/right eye rects: left around `{ x: 416, y: 279.36, w: 217.6, h: 46.08 }`, right around `{ x: 646.4, y: 279.36, w: 217.6, h: 46.08 }`.
- All 8 slices received eye source rectangles and alternating `sourceEye` values.
- Mock closed-eye landmarks changed `eyeOpenRatio` from about `0.28` to about `0.04` and set blink state to `closed`.
- Reopening the eyes after cooldown triggered blink effect: all slices flashed with minimum flash around `0.7`, and max slice speed was about `2.08`.
- Fake-camera startup loaded both Hand Landmarker and Face Landmarker: `handReady: true`, `faceReady: true`, `cameraReady: true`, `phase: running`.
- Initial combined hand/face model check was too slow in headless Chrome, so detection frequency was adjusted to `handDetectEveryNFrames = 2` and `faceDetectEveryNFrames = 6`; recheck showed about `33.6 FPS`.
- Browser page exceptions and resource logs were empty. MediaPipe emitted expected WebGL/model console info/warnings, but no blocking app error.
- Stage 4 was re-verified before Stage 5 work: fake-camera startup showed `phase: running`, `cameraReady: true`, `handReady: true`, `faceReady: true`, about `33.9 FPS`, all 8 slices received eye source rectangles, mock blink produced `flashMin` about `0.80`, and page exceptions/resource logs remained empty.

## Bugs Found

1. Combined hand/face detection at the previous interval dropped headless Chrome to about 14.6 FPS.

## Fixes Applied

1. Lowered detection frequency to `handDetectEveryNFrames = 2` and `faceDetectEveryNFrames = 6`, then re-verified startup at about 33.6 FPS.

## Remaining Risks

1. Stage 4 does not include full Stage 5 MVP integration, performance polish, face shards, or transparent cloth mode.
2. Automated eye/blink verification uses mock face landmarks; real face/eye stability still needs a live camera spot check.
3. MediaPipe CDN/model loading depends on network availability; failure must preserve fallback.

## Decision

- [x] Pass, continue to next stage
- [ ] Blocked, must fix before continuing
