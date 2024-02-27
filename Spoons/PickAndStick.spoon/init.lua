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

--- PickAndStick.menubar_title
--- Variable
--- Title to show in the menubar if `show_in_menubar` is true. [Emojis](http://emojipedia.org/rainbow/)
obj.menubar_title = "\u{1F4CC}"

-- PIckAndStick.preferred_inputs
-- Variable
-- List of user preferred inputs, in order of precedence
obj.preferred_inputs = {}

local deviceInputChangedCode = 'dIn '

-- Return the sorted keys of a table
function sortedkeys(tab)
    local keys = {}
    -- Create sorted list of keys
    for k, v in pairs(tab) do table.insert(keys, k) end
    table.sort(keys)
    return keys
end

-- function choosetable()
--     local tab = {}
--     local lists = draw.color.lists()
--     local keys = sortedkeys(lists)
--     for i, v in ipairs(keys) do
--         table.insert(tab, { title = v, fn = hs.fnutils.partial(obj.toggleColorSamples, v) })
--     end
--     return tab
-- end

local function listInputs()
    -- get list of audio inputs
    local inputs = hs.audiodevice.allInputDevices()
    local keys = sortedkeys(inputs)
    local tab = {}

    for _, v in ipairs(keys) do
        obj.logger.w("Input key: %s: %s", v, inputs[v]:name())
    end
end

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
        self.choosermenu:setTitle(self.menubar_title)
        self.choosermenu:setClickCallback(function()
            listInputs()
        end)
    end
end

return obj
