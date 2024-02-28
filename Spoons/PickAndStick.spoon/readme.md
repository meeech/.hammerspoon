Spoon to set a default device.

OSX tries to be helpful when you connect your airpods to your mac, and changes your default input device to the airpods.

This spoon will allow you to set a list of preferred inputs. This is useful if you have a laptop - when I plug in my devices at my desk, I want my Yeti. When I move away, i want to use the mac built in mic. What I don't want is my airpod mic being used. It makes the sound weak and tinny, and burns through battery.

This adds a menubar item - you can click it to pause this functionality.

You can disable the menubar item with `spoon.PIckAndStick.show_in_menubar = false`.

Usage

```lua
-- Pass in a list of your preferred inputs.
spoon.PickAndStick:start({
    "Yeti Stereo Microphone",
    "MacBook Pro Microphone"
})
```
