#Update Homebrew
update

# Install Homebrew Cask
install caskroom/cask/brew-cask

# Add support for alternate versions of Casks
tap caskroom/versions

# Install applications
cask install alfred
cask install arduino
cask install clamxav
cask install cleanmymac
cask install evasi0n
cask install flux
cask install firefox
cask install flash
cask install google-chrome
cask install hydra
cask install iterm2
cask install licecap
cask install mactracker
cask install processing
cask install skype
cask install slate
cask install spotify
cask install torbrowser
cask install transmission
cask install vienna-rss
cask install virtualbox
cask install vlc

# Add Caskroom to alfred search paths
cask alfred link

# Install Quick Look plugins
cask install qlcolorcode # Enable syntax highlighting in source files
cask install qlstephen # Preview plain text files without extension
cask install qlmarkdown # Preview Markdown files
cask install quicklook-json # Preview json files
qlmanage -r # reset Quick Look extension manager

# Upgrade any already-installed formulae
upgrade

# Remove outdated versions from the cellar
cleanup
cask cleanup