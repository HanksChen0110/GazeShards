# Stage 0 Report

## Goal

Build the runnable foundation for GazeShards without camera access or MediaPipe.

## Completed

- [x] Canvas created
- [x] Start overlay created
- [x] Debug panel created
- [x] Resize handling works
- [x] Animation loop works
- [x] FPS displayed

## Manual Test

- Browser: Headless Chrome via Chrome DevTools Protocol
- Device: Windows desktop
- Camera: Not used in Stage 0
- Result: Pass

Checked:
- `http://localhost:5173/index.html` returned HTTP 200.
- Initial page showed the start overlay and debug panel.
- Clicking `Start Experience` changed phase from `ready` to `running`.
- Clicking `Hide UI` hid the debug panel and Stage 1 controls while keeping `Show UI` available.
- Clicking `Show UI` restored the debug panel and controls.
- Resizing from 1264 x 625 to 900 x 600 updated both canvas client size and backing size.
- Debug panel displayed phase, FPS, canvas size, DPR, UI state, and fallback input mode.
- Browser console, page exceptions, and resource logs were empty after the favicon fix.

## Bugs Found

1. Browser verification initially reported a favicon 404.

## Fixes Applied

1. Added an inline empty favicon with `<link rel="icon" href="data:,">`.

## Remaining Risks

1. Stage 0 does not test camera, upload, MediaPipe, eye slices, or gesture tracking.
2. `Flip Camera` and media upload controls are intentionally disabled until Stage 1.

## Screenshots / Manual Notes

- Canvas rendered non-black visual samples during browser verification, confirming the render loop was drawing.
- Measured FPS in headless Chrome stayed around 60 FPS.

## Decision

- [x] Pass, continue to next stage
- [ ] Blocked, must fix before continuing
