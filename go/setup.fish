set -l current_dir (realpath (dirname (status -f)))
set -l parent_dir (dirname $current_dir)

source "$parent_dir/lib/messages.fish"

if not type -q go
  print_message "Installing binary for go..."
  brew install go
end

mkdir -p "$HOME/.golang"
