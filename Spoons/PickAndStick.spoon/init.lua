-- Metadata
local obj = {}
obj.__index = obj

-- Set the names
obj.name = "PickAndStick"
obj.version = "1.0"
obj.author = "meeech <meeeech@omg.lol>"
obj.homepage = "https://meeech.omg.lol"
obj.license = "MIT - https://opensource.org/licenses/MIT"

-- Logger
obj.logger = hs.logger.new('PickAndStick')

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

function showMenu()
    obj.logger.w("Show menu")

    -- get list of audio inputs
    local inputs = hs.audiodevice.allInputDevices()
    local keys = sortedkeys(inputs)
    local tab = {}

    for i, v in ipairs(keys) do
        obj.logger.w(i, v, inputs[v]:name())
        -- table.insert(tab, { title = v, fn = hs.fnutils.partial(obj.toggleColorSamples, v) })
    end

    -- obj.choosermenu:popupMenu(hs.mouse.getAbsolutePosition())
end

function obj:init()
    obj.logger.w("PickAndStick initialized")
    if (obj.show_in_menubar) then
        self.choosermenu = hs.menubar.new(true, 'picknstick')
        self.choosermenu:setTitle(self.menubar_title)
        self.choosermenu:setClickCallback(function()
            obj.logger.w("No action on click yet.")
        end)
    end
end

local function onInputChange()

end

-- preferred_inputs list of preferred inputs
function obj:start(preferred_inputs)
    -- if preferred_inputs is empty, give error message
    -- check in lua if the preferred_inputs is empty

    if preferred_inputs == nil or next(preferred_inputs) == nil then
        obj.logger.w("No preferred inputs specified. Nothing to do.")
        return
    end

    -- call initial Set Audio Input
    -- set up watcher
    -- local inputs = hs.audiodevice.allInputDevices()

    -- start audio input change watcher
end

function obj:stop()
    -- stop audio input change watcher
end

return obj
