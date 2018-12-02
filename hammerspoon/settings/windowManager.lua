hs.window.animationDuration=0

local super = {"cmd", "alt", "ctrl"}

function setWindowToLeftHalf()
  local window = hs.window.focusedWindow()
  local screen = window:screen()
  local windowFrame = window:frame()
  local screenFrame = screen:frame()

  windowFrame.x = screenFrame.x
  windowFrame.y = screenFrame.y
  windowFrame.w = screenFrame.w / 2
  windowFrame.h = screenFrame.h

  window:setFrame(windowFrame)
end

function setWindowToRightHalf()
  local window = hs.window.focusedWindow()
  local screen = window:screen()
  local windowFrame = window:frame()
  local screenFrame = screen:frame()

  windowFrame.x = screenFrame.w / 2
  windowFrame.y = 0
  windowFrame.w = screenFrame.w / 2
  windowFrame.h = screenFrame.h

  window:setFrame(windowFrame)
end

function setWindowToFullScreen()
  local window = hs.window.focusedWindow()
  local screen = window:screen()
  local windowFrame = window:frame()
  local screenFrame = screen:frame()

  windowFrame.x = screenFrame.x
  windowFrame.y = screenFrame.y
  windowFrame.w = screenFrame.w
  windowFrame.h = screenFrame.h

  window:setFrame(windowFrame)
end

hs.hotkey.bind(super, "Left", setWindowToLeftHalf)
hs.hotkey.bind(super, "Up", setWindowToFullScreen)
hs.hotkey.bind(super, "Right", setWindowToRightHalf)
