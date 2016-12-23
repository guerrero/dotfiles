set -l current_dir (realpath (dirname (status -f)))
set -l parent_dir (dirname $current_dir)

source "$parent_dir/lib/messages.fish"
source "$parent_dir/lib/file.fish"

if not type -q git
  print_message "Installing binary for git..."
  brew install git
    or exit 1
end

symlink "$current_dir/settings/gitconfig" "$HOME/.gitconfig"
