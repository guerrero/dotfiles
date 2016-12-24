set -l current_dir (realpath (dirname (status -f)))
set -l parent_dir (dirname $current_dir)

source "$parent_dir/lib/messages.fish"

if not contains nvm (ls /usr/local/Cellar/)
  print_message "Installing binary for nvm..."
  brew install nvm
end

mkdir -p "$HOME/.nvm"
