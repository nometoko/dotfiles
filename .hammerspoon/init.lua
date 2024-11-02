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
	if win == nil then -- applicationは立ち上がっているが、Windowがない時
		app:activate()
		hs.eventtap.keyStroke({ "cmd" }, "n") -- "Cmd + n"で新しいWindowを立ち上げる
		win = app:focusedWindow()
	end
	spaces.moveWindowToSpace(win, activeSpace) -- 今見ているデスクトップにウィンドウを移動する
	app:setFrontmost() -- 最前面にウィンドウを移動する
	-- Windowの最大化
	local winFrame = win:frame()
	local screenFrame = win:screen():frame()
	local newFrame = {
		x = screenFrame.x,
		y = screenFrame.y,
		w = screenFrame.w,
		h = screenFrame.h
	}
	win:setFrame(newFrame)
end

-- double tap で toggle で kitty を表示/非表示する
module.action = function()
	local appName = "kitty"
	local app = hs.application.get(appName)

	if app == nil then
		hs.application.launchOrFocus(appName)
	elseif app:isFrontmost() and app:focusedWindow() ~= nil then
		app:hide()
	else -- すでに存在する場合、window を activeSpace に移動させて focus する
		MoveFullScreenWindow(app)
	end
end

hs.hotkey.bind({ "ctrl" }, "m", function()
	local appName = "Code"
	local activeSpace = spaces.focusedSpace()
	local app = hs.application.find(appName)
	if app == nil then
		hs.application.launchOrFocus("Visual Studio Code")
	elseif app:isFrontmost() and app:focusedWindow() ~= nil then
		app:hide()
	else
		local win = app:focusedWindow()
		if win == nil then
			app:activate()
			hs.eventtap.keyStroke({ "cmd", "shift" }, "n") -- only VSCode needs "Cmd + Shift + n" for new window
			win = app:focusedWindow()
		end
		MoveFullScreenWindow(app)
	end
end)

hs.hotkey.bind({ "ctrl" }, ",", function()
	local appName = "Slack"
	local activeSpace = spaces.focusedSpace()
	local app = hs.application.find(appName)
	if app == nil then
		hs.application.launchOrFocus(appName)
	elseif app:isFrontmost() then
		app:hide()
	else
		MoveFullScreenWindow(app)
	end
end)

hs.hotkey.bind({ "ctrl" }, ".", function()
	local appName = "Google Chrome"
	local activeSpace = spaces.focusedSpace()
	local app = hs.application.find(appName)
	if app == nil then
		hs.application.launchOrFocus(appName)
	elseif app:isFrontmost() then
		app:hide()
	else
		MoveFullScreenWindow(app)
	end
end)

local timeFirstControl, firstDown, secondDown = 0, false, false
local noFlags = function(ev)
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
	.new({ events.flagsChanged, events.keyDown }, function(ev)
		if (timer.secondsSinceEpoch() - timeFirstControl) > module.timeFrame then
			timeFirstControl, firstDown, secondDown = 0, false, false
		end

		if ev:getType() == events.flagsChanged then
			if noFlags(ev) and firstDown and secondDown then
				if module.action then
					module.action()
				end
				timeFirstControl, firstDown, secondDown = 0, false, false
			elseif onlyCtrl(ev) and not firstDown then
				firstDown = true
				timeFirstControl = timer.secondsSinceEpoch()
			elseif onlyCtrl(ev) and firstDown then
				secondDown = true
			elseif not noFlags(ev) then
				timeFirstControl, firstDown, secondDown = 0, false, false
			end
		else
			timeFirstControl, firstDown, secondDown = 0, false, false
		end
		return false
	end)
	:start()
