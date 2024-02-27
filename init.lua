-- Load any spoons
hs.loadSpoon("AClock")
hs.loadSpoon("ColorPicker")
hs.loadSpoon("MicMute")
hs.loadSpoon("PickAndStick")
--

-- initialize
hs.alert.show("Hammerspoon config reloaded.")
myLogger = hs.logger.new('init', 'info')

spoon.ColorPicker.show_in_menubar = false

-- Key Handlers
local function showTime()
    spoon.AClock:toggleShow()
end

-- Bind keys
-- Spotify Volume
local function volume(volFunc)
    if not hs.spotify.isRunning() then
        return
    end

    volFunc()
    hs.alert.show(string.format("🔊 %d", hs.spotify.getVolume()))
end

hs.hotkey.bind({}, "F17", function()
    volume(hs.spotify.volumeDown)
end)

hs.hotkey.bind({ "cmd" }, "F17", function()
    volume(hs.spotify.volumeUp)
end)

---------------------------------------------------------------------
-- Config reload
hs.hotkey.bind({ "ctrl" }, "F17", function()
    hs.reload()
end)

---------------------------------------------------------------------
-- MicMute:bindHotkeys(mapping, latch_timeout)
-- We can't use this yet for latch - need to ficx our code.py
-- to use press/releaseMicMute:bindHotkeys({}, "F20")
hs.hotkey.bind({}, "F20", function()
    hs.alert.show("🔔 Mute Toggled!")
    spoon.MicMute:toggleMicMute()
end)

---------------------------------------------------------------------
-- Keycastr
hs.hotkey.bind({ "cmd" }, "F20", function()
    hs.alert.show("👀 KeyCastr Toggled!")
end)

-- hs.hotkey.bind({"alt"}, "F20", function()
--     local win = hs.window.focusedWindow()
--     local f = win:frame()
--     f.x = f.x - 100
--     win:setFrame(f)
-- end)

---------------------------------------------------------------------
-- ColorPicker
hs.hotkey.bind({ "ctrl" }, "F20", function()
    -- hs.osascript.applescript("choose color")
    spoon.ColorPicker:toggleColorSamples()
end)
