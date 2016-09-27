function print_message
  set_color green; echo -n '==> '

  if test $argv[1] = '-n'; or test $argv[1] = '--no-newline'
    set --erase argv[1]
    set_color normal; echo -n $argv
  else
    set_color normal; echo $argv
  end
end

function print_error
  set_color red; echo -n 'ERROR'
  set_color normal; echo ':' $argv
end

function print_warning
  set_color yellow; echo -n 'WARNING'

  if test $argv[1] = '-n'; or test $argv[1] = '--no-newline'
    set --erase argv[1]
    set_color normal; echo -n ':' $argv
  else
    set_color normal; echo ':' $argv
  end
end

function print_done
  echo ' ✅'
end

function clean_message_functions
  functions -e print_message print_error print_warning print_done
end
