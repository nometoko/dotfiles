-- https://github.com/ipatch/dotfiles/blob/master/jobs/macos/Users/mr-fancy/hammerspoon/ctrlDoublePress.lua
local timer = require("hs.timer")
local eventtap = require("hs.eventtap")

local events = eventtap.event.types
local module = {}
local spaces = require("hs.spaces")

if spaces.focusedSpace then
	print("activeSpace is available")
else
	print("activeSpace is not available")
end

print(hs.hotkey)

-- double tap の間隔[s]
module.timeFrame = 1

function MoveFullScreenWindow(app)
	local activeSpace = spaces.focusedSpace()
	local win = app:focusedWindow()
	-- win = win:toggleFullScreen()
	-- win = win:toggleFullScreen()
	if win == nil then
		app:activate()
		hs.eventtap.keyStroke({ "cmd" }, "n")
		win = app:focusedWindow()
	end
	spaces.moveWindowToSpace(win, activeSpace)
	app:setFrontmost()
	hs.eventtap.keyStroke({ "ctrl", "alt" }, "return")
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
			hs.eventtap.keyStroke({ "cmd", "shift" }, "n")
			win = app:focusedWindow()
		end
		spaces.moveWindowToSpace(win, activeSpace)
		hs.application.launchOrFocus("Visual Studio Code")
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
