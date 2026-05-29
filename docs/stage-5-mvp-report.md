# Stage 5 MVP Report

## Goal

Verify and complete the MVP integration path: startup, camera, hand model, face model, eye slices, pinch interaction, blink interaction, upload background, UI controls, debug controls, and fallback behavior.

## MVP Feature Checklist

- [x] Start overlay
- [x] Camera permission
- [x] Camera mirror
- [x] Hand tracking
- [x] Pinch grab
- [x] Mouse/touch fallback
- [x] Face tracking
- [x] Eye crop
- [x] Blink trigger
- [x] Blink regroup effect
- [x] Eye slices physics
- [x] Upload image/video as background
- [x] UI hide mode
- [x] Debug panel
- [x] Error fallback

## Test Devices

- [x] Desktop Chrome
- [x] Desktop Chrome with mobile viewport smoke test
- [ ] Mobile Safari
- [ ] Android Chrome

## Known Issues

- Real mobile Safari and real Android Chrome are not yet device-tested.
- Real camera lighting, framing, and hand/eye recognition stability still need a live-camera spot check.
- MediaPipe model loading may take longer than 3 seconds on a cold network path, but the camera frame is available under 3 seconds in the latest Chrome fake-camera test.

## Performance Notes

- FPS: desktop Chrome 2-minute stability sample stayed between 31.2 and 36.2 FPS.
- Model load time: full `Start` to `running` took about 5.9 seconds on the latest desktop Chrome run.
- Camera start time: camera became ready in about 0.21 seconds in the latest desktop Chrome and mobile viewport smoke tests.
- Stability: 120.6 seconds desktop Chrome run stayed in `phase: running`, with 8 slices and no runtime exceptions or resource logs.

## Completed

- [x] Stage 4 was re-verified before Stage 5 work
- [x] `startExperience()` provides the single startup path
- [x] Camera, HandTracker, FaceTracker, and EyeSliceManager run together
- [x] Eye slices keep rendering from face eye rectangles when available
- [x] Pinch can grab, drag, and release a slice
- [x] Blink can refresh eye source rectangles and trigger flash/scatter effect
- [x] Blink can pull slices back toward eye-region regroup targets
- [x] Uploaded image/video source can render as background while camera remains visible
- [x] UI can be hidden and restored
- [x] Debug panel can be toggled independently
- [x] Camera failure keeps uploaded/fallback experience usable
- [x] MediaPipe failure keeps camera and pointer fallback usable

## Automated Test

- Browser: Headless Chrome via Chrome DevTools Protocol
- URL: `http://localhost:5173/index.html`
- Camera: Chrome fake media device
- Mock data: synthetic hand landmarks, synthetic face landmarks, generated PNG upload
- Result: Pass

Checked:
- Startup reached `phase: running` with `cameraReady: true`, `handReady: true`, `faceReady: true`, 8 slices, and about `36.5 FPS`.
- Debug panel title changed to `眸影碎境 阶段 5`.
- Initial render layers were `camera + slices`.
- Mock pinch produced `PINCH_DOWN / PINCH_DRAG / PINCH_UP`; slice was grabbed, moved, released, and retained throw velocity.
- Mock face landmarks produced left/right eye rectangles and all 8 slices received source rectangles.
- Mock blink changed state from `open` to `closed` and back to `open`, triggered `lastBlinkTime`, slice flash, and scatter velocity.
- Generated PNG upload set `mediaReady: true`, `uploadedType: image`, `inputMode: camera+uploaded`, and render layers `uploaded + camera + slices`.
- Debug toggle set debug off with hidden panel, then restored it.
- Hide UI set `uiHidden: true` and restored successfully.
- Mock camera denial kept `phase: running`, changed `cameraReady` to `false`, preserved uploaded media, and set `inputMode: uploaded`.
- Browser page exceptions and resource logs were empty. MediaPipe emitted expected WebGL/model console info/warnings, but no blocking app error.

Fresh final audit on 2026-05-29:
- `localhost:5173/index.html` returned HTTP 200 after starting `python -m http.server 5173`.
- Start overlay copy now explains pinch grab, drag/throw, and blink regroup in Simplified Chinese.
- Desktop Chrome startup reached `phase: running`, `cameraReady: true`, `handReady: true`, `faceReady: true`, 8 slices, `mirrored: true`, and about `35.3 FPS`.
- Camera became ready in about `0.21s`; full model-ready running state took about `5.9s`.
- Mock blink closed/open transition triggered `lastBlinkTime`; regroup distance dropped from max `502.2` to `191.2` after updates.
- Mock pinch produced grab, drag, and release with velocity.
- Pointer fallback grab/release worked.
- Generated PNG upload produced render layers `uploaded + camera + slices`.
- Generated WebM upload loaded as `uploadedType: video`, with `muted: true`, `loop: true`, and render layers `uploaded + camera + slices`.
- Debug toggle and UI hide/restore worked.
- 120.6-second desktop stability run stayed `running`, with minimum sampled FPS `31.2`, 8 slices, no AppState errors, no runtime exceptions, and no resource logs.
- MediaPipe CDN blocked test reached `phase: running`, kept `cameraReady: true`, set both model readiness flags to `false`, retained 8 slices, and produced no runtime exceptions.
- Camera-denied test reached `phase: running`, set `inputMode: fallback`, retained 8 slices, and pointer fallback could grab a slice.
- Mobile viewport smoke test reached `phase: running` with `cameraReady: true`, `handReady: true`, `faceReady: true`, canvas fitting the viewport, about `39.2 FPS`, and no runtime exceptions.

## Bugs Found

1. Uploaded media previously replaced the camera layer, so Stage 5 could not show uploaded background and camera interaction at the same time.
2. There was no explicit debug toggle control.
3. Startup logic was inline in the click handler instead of being a reusable single startup path.
4. Start overlay copy did not explain the actual MVP gesture path clearly enough for the 10-second understanding target.
5. Blink feedback flashed and scattered slices, but did not clearly regroup them toward eye regions.
6. The report did not include the exact Stage 5 template headings from the execution plan.

## Fixes Applied

1. Render now draws uploaded media first, then overlays the camera at partial alpha, then draws slices and debug overlays.
2. Added `toggleDebugBtn` and `setDebugEnabled()`.
3. Added `startExperience()` and routed the start button through it.
4. Added `AppState.lastRenderLayers` for debug and verification.
5. Updated start overlay copy and post-start toast to explain pinch, throw, and blink regroup.
6. Added blink regroup targets so slices are pulled back toward the detected eye regions.
7. Added the required Stage 5 checklist, test-device, known-issues, and performance-note sections to this report.

## Remaining Risks

1. Automated camera uses Chrome fake media; a real camera spot check is still needed for lighting, framing, and permission UX.
2. MediaPipe CDN/model loading still depends on network availability, though failures are designed to preserve fallback.
3. Stage 5 is MVP integration only; it does not include performance polish mode, face shards, or transparent cloth mode.
4. PRD mentions mobile browser support; only a desktop Chrome mobile viewport smoke test has been run so far, not real Mobile Safari or Android Chrome.

## Decision

- [x] Pass, Stage 5 MVP complete
- [ ] Blocked, must fix before continuing
