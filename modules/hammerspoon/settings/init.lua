require("windowManager")
require("spotify")
require("reloadConfigOnChange")

function launchOrFocus(app)
  return function()
    hs.application.launchOrFocus(app)
  end
end

hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'S', launchOrFocus("Sketch"))
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'A', launchOrFocus("Atom"))
