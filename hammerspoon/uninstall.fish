set -l parent_dir (dirname (realpath (dirname (status -f))))

source "$parent_dir/lib/applications.fish"

set -l EXTRA_FILES \
  '/usr/local/Caskroom/hammerspoon/' \
  "$HOME/.hammerspoon" \
  "$HOME/Library/Application Support/com.crashlytics/org.hammerspoon.Hammerspoon" \
  "$HOME/Library/Caches/org.hammerspoon.Hammerspoon" \
  "$HOME/Library/Preferences/org.hammerspoon.Hammerspoon.plist" \
  "$HOME/Library/Saved Application State/org.hammerspoon.Hammerspoon.savedState"

uninstall_app 'Hammerspoon' $EXTRA_FILES
