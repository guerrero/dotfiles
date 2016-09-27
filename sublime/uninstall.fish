set -l parent_dir (dirname (dirname (status -f)))

source "$parent_dir/lib/applications.fish"

set -l EXTRA_FILES \
  '/usr/local/Caskroom/sublime-text/' \
  '/usr/local/bin/subl' \
  "$HOME/Library/Application Support/Sublime Text 3" \
  "$HOME/Library/Caches/com.sublimetext.3" \
  "$HOME/Library/Preferences/com.sublimetext.3.plist" \
  "$HOME/Library/Saved Application State/com.sublimetext.3.savedState"

uninstall_app 'Sublime Text' $EXTRA_FILES
