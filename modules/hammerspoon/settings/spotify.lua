function launchSpotify()
  hs.application.open("Spotify", nil, true)
end

function playOrPauseSpotify()
  if not hs.spotify.isRunning() then
    launchSpotify()
  end

  if hs.spotify.getPlaybackState() == hs.spotify.state_playing then
    hs.spotify.pause()
  else
    hs.spotify.play()
  end
end

hs.hotkey.bind({}, "F8", playOrPauseSpotify)
