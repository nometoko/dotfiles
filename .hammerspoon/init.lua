local timer = require("hs.timer")
local eventtap = require("hs.eventtap")

local events = eventtap.event.types
local module = {}
local spaces = require("hs.spaces")
-- double tap の間隔[s]
module.timeFrame = 1

-- appのWindowを立ち上げ、最大化
function MoveFullScreenWindow(app)
	local activeSpace = spaces.focusedSpace()
	local win = app:focusedWindow()
	while win == nil do
		app:activate()
		hs.eventtap.keyStroke({ "cmd" }, "n") -- "Cmd + n"で新しいWindowを立ち上げる
		win = app:focusedWindow()
	end
	spaces.moveWindowToSpace(win, activeSpace) -- 今見ているディスプレイ(デスクトップ)にウィンドウを移動する
	app:setFrontmost() -- 最前面にウィンドウを移動する
	-- Windowの最大化
	local winFrame = win:frame()
	local screenFrame = hs.screen.mainScreen():frame() -- メインディスプレイのフレームを取得
	local newFrame = {
		x = screenFrame.x,
		y = screenFrame.y,
		w = screenFrame.w,
		h = screenFrame.h,
	}
	win:setFrame(newFrame) -- ウィンドウのフレームを最大化する
end

-- double tap で toggle で kitty を表示/非表示する
module.action = function()
	local appName = "kitty"
	local app = hs.application.get(appName)

	if app == nil then -- アプリケーションが立ち上がっていない場合、立ち上げる
		hs.application.launchOrFocus(appName)
	elseif app:isFrontmost() and app:focusedWindow() ~= nil then -- アプリケーションが最前面に表示されている場合、非表示にする
		app:hide()
	else -- アプリケーションが最前面に表示されていない場合、最大化して表示する
		MoveFullScreenWindow(app)
	end
end

-- -- Ctrl + m で VSCode を表示/非表示する
-- hs.hotkey.bind({ "ctrl" }, "m", function()
-- 	local appName = "Code"
-- 	local activeSpace = spaces.focusedSpace()
-- 	local app = hs.application.find(appName)
-- 	if app == nil then -- アプリケーションが立ち上がっていない場合、立ち上げる
-- 		hs.application.launchOrFocus("Visual Studio Code")
-- 	elseif app:isFrontmost() and app:focusedWindow() ~= nil then -- アプリケーションが最前面に表示されている場合、非表示にする
-- 		app:hide()
-- 	else -- アプリケーションが最前面に表示されていない場合、最大化して表示する
-- 		local win = app:focusedWindow()
-- 		-- Windowがなかったら、"Cmd + Shift + n"で新しいWindowを立ち上げる　（VSCodeだけショートカットが異なるので先にウィンドウを立ち上げておく）
-- 		if win == nil then
-- 			app:activate()
-- 			hs.eventtap.keyStroke({ "cmd", "shift" }, "n")
-- 			win = app:focusedWindow()
-- 		end
-- 		MoveFullScreenWindow(app) --
-- 	end
-- end)
--
-- Ctrl + , で Slack を表示/非表示する
hs.hotkey.bind({ "ctrl" }, ",", function()
	local appName = "Slack"
	local activeSpace = spaces.focusedSpace()
	local app = hs.application.find(appName)
	if app == nil then -- アプリケーションが立ち上がっていない場合、立ち上げる
		hs.application.launchOrFocus(appName)
	elseif app:isFrontmost() then -- アプリケーションが最前面に表示されている場合、非表示にする
		app:hide()
	else -- アプリケーションが最前面に表示されていない場合、最大化して表示する
		MoveFullScreenWindow(app)
	end
end)

-- Ctrl + . で Google Chrome を表示/非表示する
hs.hotkey.bind({ "ctrl" }, ".", function()
	local appName = "Brave"
	local activeSpace = spaces.focusedSpace()
	local app = hs.application.find(appName)
	if app == nil then -- アプリケーションが立ち上がっていない場合、立ち上げる
		hs.application.launchOrFocus("Brave Browser")
	elseif app:isFrontmost() then -- アプリケーションが最前面に表示されている場合、非表示にする
		app:hide()
	else -- アプリケーションが最前面に表示されていない場合、最大化して表示する
		MoveFullScreenWindow(app)
	end
end)

hs.hotkey.bind({ "ctrl" }, "/", function()
	local appName = "Notion"
	local activeSpace = spaces.focusedSpace()
	local app = hs.application.find(appName)
	if app == nil then -- アプリケーションが立ち上がっていない場合、立ち上げる
		hs.application.launchOrFocus(appName)
	elseif app:isFrontmost() then -- アプリケーションが最前面に表示されている場合、非表示にする
		app:hide()
	else -- アプリケーションが最前面に表示されていない場合、最大化して表示する
		local win = app:focusedWindow()
		-- Windowがなかったら、"Cmd + Shift + n"で新しいWindowを立ち上げる　（VSCodeだけショートカットが異なるので先にウィンドウを立ち上げておく）
		if win == nil then
			app:activate()
			hs.eventtap.keyStroke({ "cmd", "shift" }, "n")
			win = app:focusedWindow()
		end
		MoveFullScreenWindow(app)
	end
end)

local timeFirstControl, firstDown, secondDown = 0, false, false
local noFlags = function(ev) -- 何も押されていないか確認
	local result = true
	for _, v in pairs(ev:getFlags()) do
		if v then
			result = false
			break
		end
	end
	return result
end

-- control だけ押されているか確認. 例えば shift+control 等は無視するようにする
local onlyCtrl = function(ev)
	local result = ev:getFlags().ctrl
	for k, v in pairs(ev:getFlags()) do
		if k ~= "ctrl" and v then
			result = false
			break
		end
	end
	return result
end

-- module.timeFrame 秒以内に2回 ctrl を押したらダブルタップとみなす
module.eventWatcher = eventtap
	.new({ events.flagsChanged, events.keyDown }, function(ev) -- flagsChanged と keyDown のイベントを監視
		if (timer.secondsSinceEpoch() - timeFirstControl) > module.timeFrame then -- module.timeFrame 秒以上経過したらリセット
			timeFirstControl, firstDown, secondDown = 0, false, false
		end

		if ev:getType() == events.flagsChanged then -- flagsChanged の場合
			if noFlags(ev) and firstDown and secondDown then -- 2回目の ctrl が押されたら action を実行
				if module.action then
					module.action()
				end
				timeFirstControl, firstDown, secondDown = 0, false, false
			elseif onlyCtrl(ev) and not firstDown then -- 1回目の ctrl が押されたら firstDown を true にする
				firstDown = true
				timeFirstControl = timer.secondsSinceEpoch() -- 1回目の ctrl が押された時間を記録
			elseif onlyCtrl(ev) and firstDown then -- 2回目の ctrl が押されたら secondDown を true にする
				secondDown = true
			elseif not noFlags(ev) then -- それ以外の場合はリセット
				timeFirstControl, firstDown, secondDown = 0, false, false
			end
		else
			timeFirstControl, firstDown, secondDown = 0, false, false
		end
		return false
	end)
	:start()
