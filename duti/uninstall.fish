set -l current_dir (realpath (dirname (status -f)))
set -l parent_dir (dirname $current_dir)

source "$parent_dir/lib/messages.fish"

function uninstall_duti
  type -q duti
    and print_message "Uninstalling binary for duti..."
    and brew uninstall duti
    and print_done
end

uninstall_duti
