#!/usr/bin/env bash

# Install apps using Homebrew-Cask (http://caskroom.io/)

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#Update Homebrew
brew update && brew upgrade

# Install Homebrew Cask
brew install caskroom/cask/brew-cask

# Add support for alternate versions of Casks
brew tap caskroom/versions

# Install applications
brew cask install alfred
brew cask install arduino
brew cask install clamxav
brew cask install cleanmymac
brew cask install cyberduck
brew cask install flux
brew cask install firefox
brew cask install flash
brew cask install google-chrome
brew cask install iterm2
brew cask install licecap
brew cask install mactracker
brew cask install processing
brew cask install skype
brew cask install slate
brew cask install spotify
brew cask install torbrowser
brew cask install transmission
brew cask install virtualbox
brew cask install vlc

# Add Caskroom to alfred search paths
brew cask alfred link

# Install Quick Look plugins
brew cask install qlcolorcode     # Syntax highlighting in source files
brew cask install qlstephen       # Plain text files preview
brew cask install qlmarkdown      # Markdown files preview
brew cask install quicklook-json  # JSON files preview
qlmanage -r                       # reset QL extension manager

# Remove outdated versions from the cellar
brew cleanup
brew cask cleanup