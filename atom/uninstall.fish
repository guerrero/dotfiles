set -l parent_dir (dirname (realpath (dirname (status -f))))

source "$parent_dir/lib/applications.fish"

set -l EXTRA_FILES \
  "$HOME/.atom" \
  "$HOME/Library/Application Support/ShipIt_stderr.log" \
  "$HOME/Library/Application Support/Atom" \
  "$HOME/Library/Application Support/ShipIt_stdout.log" \
  "$HOME/Library/Application Support/com.github.atom.ShipIt" \
  "$HOME/Library/Caches/com.github.atom" \
  "$HOME/Library/Preferences/com.github.atom.plist"

uninstall_app 'Atom' $EXTRA_FILES
