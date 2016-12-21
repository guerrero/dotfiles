set -l current_dir (realpath (dirname (status -f)))
set -l parent_dir (dirname $current_dir)

source "$parent_dir/lib/applications.fish"
source "$parent_dir/lib/file.fish"
source "$parent_dir/lib/messages.fish"

set -l SETTINGS_DIR "$current_dir/settings"
set -l CONFIG_DIR "$HOME/.atom"

function install_packages -V SETTINGS_DIR
  set packages_list (cat "$SETTINGS_DIR/package_list")
  set packages_dir "$SETTINGS_DIR/packages"
  set output_error false

  print_message "Installing packages..."

  for package in $packages_list
    if test -d "$packages_dir/$package"
      print_warning "Package $package already installed. Skipped."
    else
      apm install $package > /dev/null
      or print_error "Error trying to install $package"
        and set output_error true
    end
  end

  if eval $output_error
    print_error "Error installing one or more Atom packages"
  else
    print_message -n "Atom packages installed successfully"
    print_done
  end    
end

install_app 'Atom'
symlink $SETTINGS_DIR $CONFIG_DIR
install_packages
