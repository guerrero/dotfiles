set -l current_dir (realpath (dirname (status -f)))
set -l parent_dir (dirname $current_dir)

source "$parent_dir/lib/messages.fish"

set settings_folder "$current_dir/settings"
set installed_casks (brew cask list)

if not contains iterm2 $installed_casks
  print_message "Installing $cask cask..."
    and brew cask install iterm2
end

# Enable iTerm2 custom preferences folder
defaults write com.googlecode.iterm2 PrefsCustomFolder -string $settings_folder

# Set iTerm2 custom preferences folder to this module settings
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false
