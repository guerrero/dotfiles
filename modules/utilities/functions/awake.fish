function awake --description "Prevent the system from sleeping during specified time in hours" --argument-names hours
  if test -n "$hours"
    echo "Keeping computer awake for $hours hours"

    set seconds (math $hours \* 3600)
    caffeinate -ut $seconds
  else
    echo "Keeping computer awake forever. You can stop this process using ctrl + C."
    caffeinate -d
  end
end
