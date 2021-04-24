-- from https://github.com/jhkuperus/dotfiles/blob/master/hammerspoon/app-management.lua
-- but it uses app path instead of bundle ID (because seen apps that have the same bundle id : Pycharm vs Pycharm CE )
-- + moves the mouse relative to the center of the active window
-- + draws a border around the active window (https://github.com/prashantv/dotfiles/blob/master/.hammerspoon/border.lua)

local This = {}
global_border = nil



function This.magicSwitchingTo(appPath)
  This.switchToAndFromApp(appPath)
  This.centerMouseFocusedWindow()
  This.redrawBorder()
  hs.timer.doAfter(3, function() global_border:hide() end)
end

local previousApp = ""
function This.switchToAndFromApp(appPath)
  local focusedWindow = hs.window.focusedWindow()
  print(focusedWindow:application():path())

  if focusedWindow == nil then
    hs.application.launchOrFocus(appPath)
  elseif focusedWindow:application():path() == appPath then
    if previousApp == nil then
      hs.window.switcher.nextWindow()
    else
      previousApp:activate()
    end
  else
    previousApp = focusedWindow:application()
    hs.application.launchOrFocus(appPath)
  end
end


function This.centerMouseFocusedWindow()
    fw = hs.window.focusedWindow()
    size = fw:size()
    newPointerPosition = fw:topLeft()
    newPointerPosition.x = newPointerPosition.x + size.w/2
    newPointerPosition.y = newPointerPosition.y + size.h/2
    hs.mouse.absolutePosition(newPointerPosition)
end


function This.redrawBorder()
  win = hs.window.focusedWindow()
  if win ~= nil then
      top_left = win:topLeft()
      size = win:size()
      if global_border ~= nil then
        global_border:delete()
      end
      global_border = hs.drawing.rectangle(hs.geometry.rect(top_left['x'], top_left['y'], size['w'], size['h']))
      global_border:setStrokeColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=0.8})
      global_border:setFill(false)
      global_border:setStrokeWidth(8)
      global_border:show()
  end
end

return This