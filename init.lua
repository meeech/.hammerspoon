-- Load any spoons
hs.loadSpoon("AClock")
hs.loadSpoon("MicMute")
--

-- initialize
hs.alert.show("Hammerspoon config reloaded.")
myLogger = hs.logger.new('init', 'info')
-- myLogger.i(MicMute)

-- Key Handlers
function showTime()
    spoon.AClock:toggleShow()
end

-- Bind keys
-- Spotify Volume
hs.hotkey.bind({}, "F17", function()
    hs.spotify.volumeDown()
end)

hs.hotkey.bind({"cmd"}, "F17", function()
    hs.spotify.volumeUp()
end)

-- Config reload
hs.hotkey.bind({"ctrl"}, "F17", function()
    hs.reload()
end)

-- MicMute:bindHotkeys(mapping, latch_timeout)
-- We can't use this yet for latch - need to ficx our code.py
-- to use press/releaseMicMute:bindHotkeys({}, "F20")
hs.hotkey.bind({}, "F20", function()
    hs.alert.show("🔔 Mute Toggled!")
    spoon.MicMute:toggleMicMute()
end)

-- This is used for Keycastr
hs.hotkey.bind({"cmd"}, "F20", function()
    hs.alert.show("👀 KeyCastr Toggled!")
end)

-- hs.hotkey.bind({"alt"}, "F20", function()
--     local win = hs.window.focusedWindow()
--     local f = win:frame()
--     f.x = f.x - 100
--     win:setFrame(f)
-- end)

-- hs.hotkey.bind({"ctrl"}, "F20", function()
--     local mitchAvatar = hs.image.imageFromPath("/Users/mitchellamihod/Documents/avatar/memoji-surprised.png")

--     hs.notify.new({
--         title="Hammerspoon",
--         informativeText="Hello World",
--         -- Not working
--         -- setIdImage="/Users/mitchellamihod/Documents/avatar/memoji-surprised.png"
--         contentImage=mitchAvatar
--     }):send()
-- end)


