set -l current_dir (realpath (dirname (status -f)))
set -l parent_dir (dirname $current_dir)

source "$parent_dir/lib/applications.fish"
source "$parent_dir/lib/file.fish"

set -l SETTINGS_DIR "$current_dir/settings"
set -l CONFIG_DIR "$HOME/.hammerspoon"

install_app 'Hammerspoon'
symlink $SETTINGS_DIR $CONFIG_DIR
