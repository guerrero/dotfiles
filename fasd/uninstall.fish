set -l current_dir (realpath (dirname (status -f)))
set -l parent_dir (dirname $current_dir)

source "$parent_dir/lib/messages.fish"

function uninstall_fasd
  type -q fasd
    and print_message -n "Uninstalling binary for fasd..."
    and brew uninstall fasd
    and print_done
end

function remove_fasd_cache_folder
  print_message -n "Removing fasd cache folder..."
    and rm -rf "$_FASD_DATA"
    and set -e _FASD_DATA
    and print_done
end

uninstall_fasd
  and remove_fasd_cache_folder
