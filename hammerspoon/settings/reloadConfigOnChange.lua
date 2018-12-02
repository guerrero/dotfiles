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

  hs.notify.show(
    "Hammerspoon",
    "",
    "Configuration reloaded"
  )
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.dotfiles/hammerspoon/settings", reloadConfig):start()
