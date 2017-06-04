set -l current_dir (realpath (dirname (status -f)))
set -l parent_dir (dirname $current_dir)

source "$parent_dir/lib/messages.fish"

set -l cache_file "$HOME/.cache/fasd/data"

function install_fasd
  not type -q fasd
    and print_message "Installing binary for fasd..."
    and brew install fasd
    and print_done
end

function set_fasd_cache_folder -a filename
  print_message "Setting up fasd cache folder..."
    and mkdir -p (dirname $filename)
    and set -U _FASD_DATA $filename
    and print_done
end

install_fasd
  and set_fasd_cache_folder $cache_file
