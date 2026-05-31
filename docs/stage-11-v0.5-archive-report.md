# Stage 11 / V0.5 灵视档案馆验证报告

日期：2026-05-31

## 实现范围

- 开场升级为“灵视档案馆”，按钮为“开启灵视”。
- 新增 `AudioManager`，使用本地 BGM，单实例循环播放，带声音开关。
- BGM 播放失败或挂起时不阻塞主体验，并提示用户可点击声音按钮开启。
- 普通塔罗牌池移除愚者，愚者作为 `foolCard` 独立隐藏彩蛋。
- `FaceShard` 增加 `regionType`，抓取快照返回证据类型。
- `CardRevealController` 根据碎片证据类型选择普通卡牌候选。
- 揭幕完成后在 Canvas 中显示“你的灵视档案”和对应判词。
- 新增 `FoolEasterEgg`，只有普通揭幕后才监听 2 秒 3 次眨眼彩蛋。
- 摄像头失败时创建 mock 脸部碎片，fallback 仍保留可交互的视觉体验。

## 验证记录

- `powershell -ExecutionPolicy Bypass -File .\tests\v0.5-static-contract.ps1`
  - 结果：通过。
- `powershell -ExecutionPolicy Bypass -File .\tests\v0.4-static-contract.ps1`
  - 结果：通过。
- 浏览器桌面视口
  - 页面进入 `running`。
  - fallback 下生成 7 个 mock 脸部碎片。
  - 普通待揭示牌为正义，不包含愚者。
  - 控制台无 error。
- 浏览器移动视口 `390x844`
  - 页面进入 `running`。
  - 声音开关为 54px 固定小按钮。
  - 卡槽、碎片、控制按钮不重叠。
  - 控制台无 error。

## 截图

- 桌面：`docs/stage-11-v0.5-desktop.png`
- 移动端：`docs/stage-11-v0.5-mobile.png`

## 已知限制

- 当前自动化浏览器无法稳定保持 pointer down 0.8 秒，因此“拖住脸部碎片入槽停留后揭幕”的完整动作仍需在真实浏览器或带摄像头设备上手测。
- 自动化验证已覆盖静态契约、启动、fallback、普通牌池、BGM 降级、桌面/移动布局和控制台错误。
