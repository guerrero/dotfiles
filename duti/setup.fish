set -l current_dir (realpath (dirname (status -f)))
set -l parent_dir (dirname $current_dir)

source "$parent_dir/lib/messages.fish"

function install_duti
  not type -q duti
    and print_message "Installing binary for duti..."
    and brew install duti
    and print_done
end

function set_default_app_handlers
  print_message -n "Setting default apps for handle files..."
    and duti "$current_dir/settings/handlers"
    and print_done
end

install_duti
  and set_default_app_handlers
