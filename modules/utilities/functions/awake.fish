function awake -d "Prevent the system from sleeping during specified time in hours"
  set hours $argv[1]
  set seconds (math $hours \* 3600)

  echo "Keeping computer awake for $hours hours"
  caffeinate -ut $seconds
end
