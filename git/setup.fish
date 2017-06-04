set -l current_dir (realpath (dirname (status -f)))
set -l parent_dir (dirname $current_dir)

source "$parent_dir/lib/messages.fish"
source "$parent_dir/lib/file.fish"

function install_git
  not type -q git
    and print_message "Installing binary for git..."
    and brew install git
    and print_done
end

install_git
  and symlink "$current_dir/settings/gitconfig" "$HOME/.gitconfig"
