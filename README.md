# Chrome 更新提示开关（macOS）

一个单文件 macOS 小工具，用来屏蔽/恢复 Chrome 在不受支持的 macOS 上弹出的横幅提示：

> 若要继续接收 Google Chrome 更新，您需要更新至 macOS 13 或更高版本。该电脑目前使用的是 macOS 12。

## 原理

设置 Chrome 官方策略/偏好 `SuppressUnsupportedOSWarning`（Chrome 49+ 支持）：

- 开启：`defaults write com.google.Chrome SuppressUnsupportedOSWarning -bool true`
- 恢复：`defaults delete com.google.Chrome SuppressUnsupportedOSWarning`

设置必须在 Chrome 完全退出后写入，再重新打开 Chrome 才会生效。本工具自动完成「退出 → 写入 → 重开」全过程。

## 使用

1. 双击 `Chrome 更新提示开关.app`（或用下方命令自行编译）。
2. 输入 `1` 回车 = 屏蔽提示；输入 `2` 回车 = 恢复提示。直接回车默认执行 `1`。
3. Chrome 会被自动关闭并重开，几秒后弹出结果提示。

无需管理员权限，不修改系统文件，不联网。

## 编译

```bash
osacompile -o "Chrome 更新提示开关.app" chrome-update-banner-toggle.applescript
xattr -cr "Chrome 更新提示开关.app"
```

## 实测环境

- macOS 12.7.6
- Google Chrome 150.0.7871.125

对照验证：未设置时横幅出现；设置后重开 Chrome，横幅消失。

## 影响与限制

- 只隐藏这一条「不受支持的系统」横幅；不影响浏览、书签、密码、扩展，也不会关闭自动更新。
- 不解决根本问题：Chrome 150 是 macOS 12 最后支持的大版本，Chrome 151+ 不再支持 macOS 12。
- Chrome 菜单里的更新状态小圆点不在处理范围内。
- 升级系统或重装 Chrome 后设置可能失效，重新运行一次即可。

## 恢复

输入 `2` 回车即可恢复默认行为；也可以手动执行 `defaults delete com.google.Chrome SuppressUnsupportedOSWarning` 后重启 Chrome。

## 授权

MIT
