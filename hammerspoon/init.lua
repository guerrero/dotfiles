hs.window.animationDuration=0

local super = {"cmd", "alt", "ctrl"}

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
  local window = hs.window.focusedWindow()
  local screen = window:screen()
  local windowFrame = window:frame()
  local screenFrame = screen:frame()

  windowFrame.x = screenFrame.x
  windowFrame.y = screenFrame.y
  windowFrame.w = screenFrame.w / 2
  windowFrame.h = screenFrame.h

  window:setFrame(windowFrame)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", function()
  local window = hs.window.focusedWindow()
  local screen = window:screen()
  local windowFrame = window:frame()
  local screenFrame = screen:frame()

  windowFrame.x = screenFrame.x
  windowFrame.y = screenFrame.y
  windowFrame.w = screenFrame.w
  windowFrame.h = screenFrame.h

  window:setFrame(windowFrame)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
  local window = hs.window.focusedWindow()
  local screen = window:screen()
  local windowFrame = window:frame()
  local screenFrame = screen:frame()

  windowFrame.x = screenFrame.w / 2
  windowFrame.y = 0
  windowFrame.w = screenFrame.w / 2
  windowFrame.h = screenFrame.h

  window:setFrame(windowFrame)
end)

function reloadConfig(files)
  doReload = false

  for _, file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end

  if doReload then
    hs.reload()
  end

  hs.alert.show("Config loaded")
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

hs.hotkey.bind(super, ',', function()
  hs.execute(". ~/Desktop/tmp/foo.sh")
end)
