set -l current_dir (realpath (dirname (status -f)))
set -l parent_dir (dirname $current_dir)

source "$parent_dir/lib/messages.fish"


if not type -q duti
  print_message "Installing binary for duti..."
  brew install duti
end

type -q duti
  and print_message -n "Setting default apps for handle files..."
  and duti "$current_dir/settings/handlers"
  and print_done
