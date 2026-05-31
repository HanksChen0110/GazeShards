# GazeShards Project Rules

## Project Goal

Build GazeShards as a staged Web AR interaction MVP. The MVP target is a single-file `index.html` experience where users can eventually see eye slices, grab them with pinch gestures, and trigger visual changes by blinking.

## Current Stage

Stage 0, Stage 1, Stage 2, Stage 3, Stage 4, Stage 5, Stage 6, Stage 7, and Stage 8 have passed. Next implementation work is Stage 9 only after an explicit request.

Stage 8 is V0.3 art upgrade:
- Fixed top eye preview that does not move with draggable shards
- Square face-region shards using eye, brow, nose, mouth, cheek, forehead, and small face regions
- Default grayscale camera background with blur and film grain
- Clear grayscale shard crops over the blurred background
- Settings toggle for grayscale camera styling
- Colored tarot card layer that is not affected by grayscale styling
- Open-palm gesture switches to the next tarot card with cooldown
- Three valid blinks summon The Fool card and enter an end state
- Stage 8 report after verification

Transparent cloth mode is deferred to a later stage after Stage 8.

Stage 7 includes:
- `FaceShardManager`
- Face-region shards from forehead, nose, mouth, cheeks, and small random regions
- Blink-triggered face shard reassembly
- Face proximity scatter/reassemble response
- Pinch or pointer grab for face shards
- Stage 7 report after verification

Stage 6 includes:
- Performance manager with auto/high/low modes
- Low-performance detection interval and particle cap
- Recording mode
- Keyboard shortcuts: `H`, `D`, `R`, and `Esc`
- Friendlier first-use guidance
- UI polish and mobile touch target improvements
- Stage 6 report after verification

Stage 5 includes:
- MVP integration and acceptance
- Startup flow review
- Combined model/camera/visual-element path
- Error fallback review
- Final MVP report after verification

Stage 5 must preserve the complete path:
- Start experience
- Camera starts or fallback remains usable
- Hand and face models load without blocking the page on failure
- Eye slices render from camera eye regions when face tracking is available
- Pinch can grab, drag, and release slices
- Blink can regroup and flash slices
- Uploaded media can be used as a background layer while the camera interaction path remains visible
- UI and debug controls can be hidden or toggled

Stage 5 already includes:
- `startExperience()` as the single startup path
- Combined camera, hand, face, eye slice, pinch, blink, upload, UI, and debug MVP path
- Uploaded image/video rendering as a background layer while camera remains visible
- Explicit debug toggle control
- Stage 5 MVP report after verification

Stage 4 already includes:
- FaceTracker integration for MediaPipe Tasks Vision
- Left/right eye rectangles
- Real eye crop source rectangles
- Blink detection
- Blink visual effect routed to EyeSliceManager
- Stage 4 report after verification

Stage 3 already includes:
- HandTracker integration for MediaPipe Tasks Vision
- Pinch state machine with hysteresis
- Mirrored camera coordinate mapping for hand landmarks
- PINCH_DOWN / PINCH_DRAG / PINCH_UP events
- Routing pinch events through the same EyeSliceManager path as pointer fallback
- Debug state for hand and pinch tracking
- Stage 3 report after verification

Stage 2 already includes:
- `EyeSlice` visual element class
- `EyeSliceManager`
- Mock eye slices without MediaPipe
- Mouse and touch pointer fallback
- Dragging and release inertia
- Slowdown, rotation, and simple visual texture
- Stage 2 report after verification

Stage 1 already includes:
- Camera access through `navigator.mediaDevices.getUserMedia()`
- Front camera mirrored by default
- Camera stop and switch attempts
- Image upload as a background visual source
- Video upload as a muted looping background visual source
- Graceful camera failure handling
- Stage 1 report after verification

Stage 0 already includes:
- Fullscreen black page
- Fullscreen canvas
- Start overlay
- Basic controls
- Debug panel
- Canvas resize handling
- `requestAnimationFrame` render loop
- FPS display

Stage 5 does not include:
- Performance polish mode
- Face shards
- Transparent cloth mode

## Development Rules

- Prefer a single `index.html` for the MVP.
- Use plain JavaScript.
- Use Simplified Chinese for visible UI copy from Stage 1 onward.
- Do not use Vue, React, or a build tool for the MVP.
- Do not skip stages.
- Do not start the next stage until the current stage report is written and verified.
- Keep fallback behavior as a first-class requirement in later stages.
- MediaPipe failures must never make the whole page unusable in later stages.

## Verification

Run locally with:

```bash
python -m http.server 5173
```

Open:

```text
http://localhost:5173
```

For each stage:
- Check the browser console for blocking errors.
- Manually test the stage's core path.
- Update the matching `docs/stage-X-report.md`.
- Fix blockers before moving to the next stage.
