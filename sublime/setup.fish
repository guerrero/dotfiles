set -l current_dir (realpath (dirname (status -f)))
set -l parent_dir (dirname $current_dir)

source "$parent_dir/lib/messages.fish"
source "$parent_dir/lib/applications.fish"
source "$parent_dir/lib/file.fish"

set -l SETTINGS_DIR "$current_dir/settings"
set -l CONFIG_DIR "$HOME/Library/Application Support/Sublime Text 3/Packages/User"
set PACKAGE_CONTROL_FILE "$HOME/Library/Application Support/Sublime Text 3/Installed Packages/Package Control.sublime-package"

function install_package_control
  test -f $PACKAGE_CONTROL_FILE; and test -s $PACKAGE_CONTROL_FILE
    and print_message "Package Control is already installed"
    and return 0
  or print_message -n "Installing Package Control..."
    and mkdir -p (dirname $PACKAGE_CONTROL_FILE)
    and subl
    and sleep 2
    and subl --command install_package_control
    and sleep 4
    and print_done
    and return 0
  or print_error \n"Error trying to install Sublime Text Package Control"
    and return 1
end

install_app 'Sublime Text'
  and install_package_control
  and mkdir -p (dirname $CONFIG_DIR)
  and symlink $SETTINGS_DIR $CONFIG_DIR

set -e PACKAGE_CONTROL_FILE

functions -e install_package_control

clean_message_functions
