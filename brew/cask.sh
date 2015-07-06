#!/usr/bin/env bash

# Install apps using Homebrew-Cask (http://caskroom.io/)

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until `cask.sh` has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Intall Homebrew Cask
brew install caskroom/cask/brew-cask

# Changes the path where symlinks to the cask applications will be generated
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Tap homebrew cask versions to enable installation of alternate Cask versions
brew tap caskroom/versions

# Install applications
brew cask install alfred
brew cask install atom
brew cask install clamxav
brew cask install cleanmymac
brew cask install cyberduck
brew cask install dash
brew cask install flux
brew cask install firefox
brew cask install flash
brew cask install google-chrome
brew cask install iterm2
brew cask install imageoptim
brew cask install licecap
brew cask install mactracker
brew cask install skype
brew cask install slack
brew cask install slate
brew cask install sublime-text3
brew cask install spotify
brew cask install torbrowser
brew cask install transmission
brew cask install virtualbox
brew cask install vlc

# Remove outdated versions from the cellar
brew cleanup
brew cask cleanup
