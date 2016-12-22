set -l current_dir (realpath (dirname (status -f)))
set -l parent_dir (dirname $current_dir)

source "$parent_dir/lib/messages.fish"

set settings_folder "$current_dir/settings"
set installed_casks (brew cask list)

if not contains iterm2 $installed_casks
  print_message "Installing $cask cask..."
    and brew cask install iterm2
end

defaults write com.googlecode.iterm2 PrefsCustomFolder -string $settings_folder
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
