function serve --description "Start a local, live-reload web server in the current terminal directory"
  # Check if browser-sync is installed
  if not type -q browser-sync;
    echo "browser-sync is not installed. Aborting command."
    return 1
  end

  set LOCAL_IP (ipconfig getifaddr en0)
  browser-sync start -s -f . --no-notify --host $LOCAL_IP --port 9000
end
