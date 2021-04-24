hs.window.animationDuration = 0

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

local ms = require('magic-switch')
local log = hs.logger.new('johnyyyyyyyyyy','debug')

local hyperKey = {'cmd','ctrl','option', 'shift'}


local applicationHotkeys = {
    q = '/Applications/IntelliJ IDEA CE.app',
    w = '/Applications/iTerm.app',
    e = '/Applications/Postman.app',
    r = '/Applications/Google Chrome.app',
    a = '/Applications/Slack.app',
    s = '/Applications/Mail.app',
    d = '/Applications/Pycharm.app',
    f = '/Applications/Visual Studio Code.app',
    z = '/Applications/DBeaver.app',
    x = '/Applications/Pritunl.app'
  }


for key, appPath in pairs(applicationHotkeys) do
    hs.hotkey.bind(hyperKey, key, function()
        ms.magicSwitchingTo(appPath)
    end)
end


-- https://stackoverflow.com/questions/54151343/how-to-move-an-application-between-monitors-in-hammerspoon
function moveWindowToDisplay(d)
    return function()
      local displays = hs.screen.allScreens()
      local win = hs.window.focusedWindow()
      win:moveToScreen(displays[d], false, true)
      ms.centerMouseFocusedWindow()
    end
  end
  
hs.hotkey.bind(hyperKey, "1", moveWindowToDisplay(2))
hs.hotkey.bind(hyperKey, "2", moveWindowToDisplay(3))
hs.hotkey.bind(hyperKey, "3", moveWindowToDisplay(1))


-- function applicationWatcher(appName, eventType, appObject)
--     if (eventType == hs.application.watcher.activated) then
--         log.i(appObject:bundleID())
--     end
-- end
-- appWatcher = hs.application.watcher.new(applicationWatcher)
-- appWatcher:start()