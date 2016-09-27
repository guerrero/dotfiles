set -l parent_dir (dirname (dirname (status -f)))

source "$parent_dir/lib/applications.fish"
source "$parent_dir/lib/file.fish"

set -l SETTINGS_DIR (dirname (status -f))/settings
set -l CONFIG_DIR "$HOME/.hammerspoon"

install_app 'Hammerspoon'
symlink $SETTINGS_DIR $CONFIG_DIR
