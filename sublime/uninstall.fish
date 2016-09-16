#
# Sublime Text uninstall
#

set CURRENT_DIR (dirname (status --current-filename))
set SUBLIME_TEXT_PATH '/Applications/Sublime Text.app/'
set SUBLIME_FILES \
  '/usr/local/Caskroom/sublime-text/' \
  '/usr/local/bin/subl' \
  "$HOME/Library/Application Support/Sublime Text 3" \
  "$HOME/Library/Caches/com.sublimetext.3" \
  "$HOME/Library/Preferences/com.sublimetext.3.plist" \
  "$HOME/Library/Saved Application State/com.sublimetext.3.savedState"

source "$CURRENT_DIR/../lib/messages.fish"

sudo -v

function sublime_is_installed
  test -d $SUBLIME_TEXT_PATH; and test -s $SUBLIME_TEXT_PATH
    and return 0
    or print_message "Sublime Text is not installed or its path is different from /Applications/"
    and return 1
end

function uninstall_sublime_cask
  print_message -n "Uninstalling Sublime Text cask..."
    and brew cask zap sublime-text > /dev/null
    and print_done
end

function uninstall_sublime_app
  print_message -n "Removing Sublime Text app..."
    and rm -rf $SUBLIME_TEXT_PATH
    and print_done
end

function remove_sublime_files
  for file in $SUBLIME_FILES
    print_message -n "Removing $file..."
      and rm -rf $file > /dev/null
      and print_done
  end
end

function uninstall_sublime
  type -q brew; and brew cask > /dev/null
    and uninstall_sublime_cask
    or uninstall_sublime_app
    and remove_sublime_files

  print_message "Uninstalled Sublime Text app successfully"
end

if sublime_is_installed
  uninstall_sublime
end

set -e CURRENT_DIR
set -e SUBLIME_TEXT_PATH
set -e SUBLIME_FILES

functions -e \
  sublime_is_installed \
  uninstall_sublime_cask \
  uninstall_sublime_app \
  remove_sublime_files \
  uninstall_sublime

clean_message_functions

exit 0
