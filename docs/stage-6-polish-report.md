# Stage 6 Polish Report

## Goal

Improve the Stage 5 MVP so it is more suitable for demo and screen recording, with performance fallback, friendlier controls, guidance, and mobile-touch polish.

## Completed

- [x] Added `PerformanceManager`
- [x] Added auto/high/low performance modes
- [x] Added low-mode hand and face detection intervals
- [x] Added particle cap for high and low modes
- [x] Added recording mode
- [x] Added tiny recording exit button
- [x] Added keyboard shortcuts: `H` hide UI, `D` debug, `R` reset visuals, `Esc` exit recording mode
- [x] Added reset visual button
- [x] Added first-use guide panel
- [x] Hid toast and guide in recording mode
- [x] Improved mobile touch target size
- [x] Added scanline/glow atmosphere pass for stronger visual presence

## Manual Test

- Browser: Headless Chrome via Chrome DevTools Protocol
- URL: `http://localhost:5173/index.html`
- Camera: Chrome fake media device
- Result: Pass

Checked:
- Startup reached `phase: running`, `cameraReady: true`, `handReady: true`, `faceReady: true`, about `39.8 FPS`.
- Debug panel title showed `眸影碎境 阶段 7`, confirming the combined Stage 6/7 build loaded.
- Controls included `隐藏界面`, `关闭调试`, `录屏模式`, `重置画面`, `性能 自动`, and `切换镜头`.
- First-use guide panel appeared after startup.
- Auto performance mode switched to `auto/low` when simulated FPS stayed below threshold; low mode capped particles at 60.
- Auto performance mode restored to `auto/high` when simulated FPS stayed above threshold; high mode allowed 160 particles.
- Manual performance mode button cycled to `性能 高`.
- Recording mode applied `body.recording-mode` and showed the tiny exit button.
- `H`, `D`, and `R` keyboard shortcuts toggled UI, toggled debug, and reset visuals.
- 20-second stability smoke test stayed in `phase: running`, with sampled FPS between about `33.2` and `36.0`, no app errors, and no browser exceptions/resource logs.
- Mobile viewport smoke test reached `phase: running`, canvas matched viewport, controls stayed within viewport, `touch-action: none`, about `39.1 FPS`, and no browser exceptions/resource logs.

## Bugs Found

- `localhost:5173` was not running during the first connectivity check. This is an environment state issue, not an app bug.
- No Stage 6 app blocker was found in browser automation.

## Fixes Applied

- The local server will be started before final Stage 6/7 verification.
- Started `python -m http.server 5173` before browser verification.

## Remaining Risks

- Low-performance mode is validated with simulated FPS and browser automation; real low-end device behavior still needs a device spot check.
- Recording mode hides UI but does not implement browser-level recording, which remains outside scope.

## Decision

- [x] Pass, continue to next stage
- [ ] Blocked, must fix before continuing
