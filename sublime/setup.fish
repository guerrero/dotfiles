#
# Sublime Text setup
#

set CURRENT_DIR (dirname (status --current-filename))
set SETTINGS_DIR "$CURRENT_DIR/settings"
set SUBLIME_CONFIG_DIR "$HOME/Library/Application Support/Sublime Text 3/Packages/User"
set PACKAGE_CONTROL_FILE "$HOME/Library/Application Support/Sublime Text 3/Installed Packages/Package Control.sublime-package"
set SUBLIME_TEXT_PATH '/Applications/Sublime Text.app/'

source "$CURRENT_DIR/../lib/messages.fish"

function sublime_is_installed
  test -d $SUBLIME_TEXT_PATH; and test -s $SUBLIME_TEXT_PATH
    and print_message "Sublime Text is already installed"
    and return 0
    or return 1
end

function install_sublime
  if type -q brew
    not brew cask > /dev/null
      and print_message -n "Adding Homebrew-Cask to Homebrew's repos list..."
      and brew tap caskroom/cask > /dev/null
      and print_done

    print_message -n "Installing Sublime Text..."
      and brew cask install sublime-text > /dev/null
      and print_done
  else
    print_error "Required dependency brew is not installed. Aborting Sublime Text setup"
  end
end

function package_control_is_installed
  test -f $PACKAGE_CONTROL_FILE; and test -s $PACKAGE_CONTROL_FILE
    and print_warning "Package Control is already installed"
    and return 0
    or return 1
end

function install_package_control
  print_message -n "Installing Package Control..."
    and mkdir -p (dirname $PACKAGE_CONTROL_FILE)
    and curl -fsSL -o $PACKAGE_CONTROL_FILE 'https://packagecontrol.io/Package%20Control.sublime-package' > /dev/null
    and print_done
end


function sublime_settings_is_linked
  test -L $SUBLIME_CONFIG_DIR; and test (readlink $SUBLIME_CONFIG_DIR) = $SETTINGS_DIR
    and print_warning "Sublime settings are already linked"
    and return 0
    or return 1
end

function link_sublime_settings
  test -e $SUBLIME_CONFIG_DIR
    and print_message -n 'Replacing default Sublime settings by dotfiles settings...'
    and rm -rf $SUBLIME_CONFIG_DIR
    and print_done
    or mkdir -p (dirname $SUBLIME_CONFIG_DIR)

  print_message -n 'Linking sublime settings...'
    and ln -s "$SETTINGS_DIR" $SUBLIME_CONFIG_DIR > /dev/null
    and print_done
end

if not sublime_is_installed
  install_sublime
end

if not package_control_is_installed
  install_package_control
end

if not sublime_settings_is_linked
  link_sublime_settings
end

set -e SUBLIME_DOTFILES_DIR
set -e SETTINGS_DIR
set -e SUBLIME_CONFIG_DIR
set -e PACKAGE_CONTROL_FILE
set -e SUBLIME_TEXT_PATH

functions -e \
  sublime_settings_is_linked \
  sublime_is_installed \
  install_sublime \
  link_sublime_settings \
  package_control_is_installed \
  install_package_control

clean_message_functions

exit 0
