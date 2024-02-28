-- Metadata
local obj = {}
obj.__index = obj

-- Set the names
obj.name = "PickAndStick"
obj.version = "1.0"
obj.author = "meeech <meeeech@omg.lol>"
obj.homepage = "https://meeech.omg.lol"
obj.license = "MIT - https://opensource.org/licenses/MIT"

--- PickAndStick.logger
--- Variable
--- Logger object used within the Spoon. Can be accessed to set the default log level for the messages coming from the Spoon.
obj.logger = hs.logger.new('PickAndStick')

--- PickAndStick.show_in_menubar
--- Variable
--- If `true`, show an icon in the menubar to trigger the color picker
obj.show_in_menubar = true

--- PickAndStick.menubar_title_on
--- Variable
--- Title to show in the menubar if `show_in_menubar` is true. [Emojis](http://emojipedia.org/rainbow/)
obj.menubar_title_on = "📌"

--- PickAndStick.menubar_title_off
--- Variable
--- Title to show in the menubar if `show_in_menubar` is true. [Emojis](http://emojipedia.org/rainbow/)
obj.menubar_title_off = "📌⏸️"

-- PIckAndStick.preferred_inputs
-- Variable
-- List of user preferred inputs, in order of precedence
obj.preferred_inputs = {}

local deviceInputChangedCode = 'dIn '

-- https://www.hammerspoon.org/docs/hs.audiodevice.watcher.html#setCallback
function PSonInputChange(whatChanged)
    if whatChanged ~= deviceInputChangedCode then
        obj.logger.i('Input not change')
        return
    end

    for _, v in ipairs(obj.preferred_inputs) do
        local inputDevice = hs.audiodevice.findInputByName(v)
        obj.logger.w('Input device', inputDevice)
        if inputDevice ~= nil then
            local success = inputDevice:setDefaultInputDevice()
            if success == false then
                obj.logger.w('There was a problem setting input to:', v)
            else
                obj.logger.w('Set input to:', v)
            end
            return
        end
    end
end

-- preferred_inputs list of preferred inputs
function obj:start(preferred_inputs)
    if preferred_inputs == nil or next(preferred_inputs) == nil then
        obj.logger.w("No preferred inputs specified. Nothing to do.")
        return
    end
    self.preferred_inputs = preferred_inputs

    PSonInputChange(deviceInputChangedCode)

    hs.audiodevice.watcher.setCallback(PSonInputChange)
    hs.audiodevice.watcher:start()
end

function obj:stop()
    -- stop audio input change watcher
    hs.audiodevice.watcher:start()
    hs.audiodevice.watcher.setCallback(nil)
end

function obj:init()
    obj.logger.w("PickAndStick initialized")
    if (obj.show_in_menubar) then
        self.choosermenu = hs.menubar.new(true, 'picknstick')
        self.choosermenu:setTitle(self.menubar_title_on)

        self.choosermenu:setClickCallback(function()
            if hs.audiodevice.watcher.isRunning() == true then
                obj:stop()
                self.choosermenu:setTitle(self.menubar_title_off)
            else
                obj:start(obj.preferred_inputs)
                self.choosermenu:setTitle(self.menubar_title_on)
            end
        end)
    end
end

return obj
