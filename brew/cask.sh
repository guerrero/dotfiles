#!/usr/bin/env bash

# Install apps using Homebrew-Cask (http://caskroom.io/)

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until `cask.sh` has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Update Homebrew to ensure we are using the latest Homebrew-cask version
brew update

# Intall Homebrew Cask
brew install caskroom/cask/brew-cask

# Changes the path where symlinks to the cask applications will be generated
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Tap homebrew cask versions to enable installation of alternate Cask versions
brew tap caskroom/versions

# Install Java 6 required by some apps
brew cask install java6

# Install Silverlight required by Netflix
brew cask install silverlight

# Install applications
brew cask install alfred
brew cask install atom
brew cask install clamxav
brew cask install cleanmymac
brew cask install cyberduck
brew cask install dash
brew cask install firefox
brew cask install firefoxdeveloperedition
brew cask install flux
brew cask install google-chrome
brew cask install google-hangouts
brew cask install imageoptim
brew cask install iterm2
brew cask install licecap
brew cask install mactracker
brew cask install sketch
brew cask install skype
brew cask install slack
brew cask install slate
brew cask install spotify
brew cask install sublime-text3
brew cask install telegram
brew cask install torbrowser
brew cask install transmission
brew cask install virtualbox
brew cask install vlc

# Tap homebrew cask fonts to enable installation of binary font files
brew tap caskroom/fonts

# Install fonts
brew cask install font-cabin
brew cask install font-fira-sans
brew cask install font-lato
brew cask install font-merriweather
brew cask install font-merriweather-sans
brew cask install font-montserrat
brew cask install font-open-sans
brew cask install font-oxygen
brew cask install font-pt-sans
brew cask install font-pt-serif
brew cask install font-quattrocento-sans
brew cask install font-roboto
brew cask install font-source-sans-pro
brew cask install font-source-serif-pro
brew cask install font-varela
brew cask install font-varela-round

# Remove outdated versions from the cellar
brew cleanup
brew cask cleanup
