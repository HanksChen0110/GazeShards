# Stage 10 / V0.4 诡秘塔罗揭幕升级验证报告

日期：2026-05-31

## 实现范围

- 已接入 9 张塔罗 PNG 资产：1 张背面与 8 张正面角色牌。
- 塔罗牌默认进入 `faceDown` 状态，只展示 `assets/card_back.png`。
- 张掌手势只切换下一张待揭示牌，不直接展示正面。
- 新增 `RitualState` 与 `CardRevealController`，脸部碎片进入左侧牌槽并停留 0.8s 后触发揭幕。
- 新增背面到正面的纵向揭幕动画，完成后进入 `revealed`。
- 保留三次眨眼召唤愚者的结束态路径。
- 开场遮罩改为半透明幕布，点击后向两侧退场。
- 摄像头失败时仍进入 fallback，可继续显示 mock 切片、塔罗背面与 UI。

## 验证记录

- `powershell -ExecutionPolicy Bypass -File .\tests\v0.4-static-contract.ps1`
  - 结果：通过。
- 浏览器桌面视口 `1280x720`
  - 页面进入 `running`。
  - 摄像头权限失败时 fallback 仍可用。
  - 调试面板显示 `塔罗状态: faceDown`、`塔罗图片: 真实资产`。
  - 控制台无 error。
- 浏览器移动视口 `390x844`
  - 页面进入 `running`。
  - 调试关闭后，顶部观察窗、左侧塔罗槽、碎片和底部控件正常显示。
  - 控制台无 error。

## 截图

- 桌面：`docs/stage-10-v0.4-desktop.png`
- 移动端：`docs/stage-10-v0.4-mobile.png`

## 已知限制

- 当前自动化环境无法提供真实摄像头人脸，因此真实 pinch + 真实脸部碎片入槽路径仍需在带摄像头设备上手测。
- 自动化验证覆盖了静态契约、真实资产加载、fallback 启动、桌面和移动布局。
