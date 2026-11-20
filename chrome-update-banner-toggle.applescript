set appTitle to "Chrome 更新提示开关"
activate

-- 极简菜单：1 回车 = 开启屏蔽，2 回车 = 关闭屏蔽
set choice to ""
repeat until choice is "1" or choice is "2"
	try
		set d to display dialog appTitle & return & return & ¬
			"1  =  屏蔽更新提示（开启）" & return & ¬
			"2  =  恢复更新提示（关闭）" & return & return & ¬
			"输入数字后按回车（直接回车 = 1）：" ¬
			default answer "1" buttons {"确定", "取消"} default button "确定" with title appTitle
	on error number -128
		return
	end try
	if button returned of d is "取消" then return
	set choice to text returned of d
end repeat

-- 关闭 Chrome，避免设置在退出时被覆盖
set chromePID to ""
try
	set chromePID to do shell script "pgrep -f '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' | head -n 1"
end try

if chromePID is not "" then
	try
		tell application "Google Chrome" to quit
	end try
	repeat 30 times
		try
			do shell script "pgrep -f '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' >/dev/null 2>&1"
			delay 0.3
		on error
			exit repeat
		end try
	end repeat
end if

if choice is "1" then
	do shell script "defaults write com.google.Chrome SuppressUnsupportedOSWarning -bool true"
	set msg to "已开启：Chrome 顶部那条更新提示横幅已隐藏。"
else
	do shell script "defaults delete com.google.Chrome SuppressUnsupportedOSWarning 2>/dev/null || true"
	set msg to "已关闭：Chrome 的更新提示横幅已恢复显示。"
end if

-- 重新打开 Chrome，让设置立即生效
try
	tell application "Google Chrome" to activate
end try

display dialog msg & return & return & "Chrome 已自动重新打开。" buttons {"完成"} default button 1 with title appTitle
