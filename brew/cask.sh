#!/usr/bin/env bash

# Install apps using Homebrew-Cask (http://caskroom.io/)

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until `cask.sh` has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Update Homebrew to ensure we are using the latest Homebrew-cask version
brew update

# Intall Homebrew Cask
brew tap caskroom/cask

# Tap homebrew cask versions to enable installation of alternate Cask versions
brew tap caskroom/versions

install() {
  for cask in $@; do
    brew cask install $cask
  done
}

# Install Java 6 required by some apps
install java6

# Install Silverlight required by Netflix
install silverlight

# Install applications
install alfred
install atom
install clamxav
install cleanmymac
install cyberduck
install dash
install firefox
install flux
install google-chrome
install chromium
install google-hangouts
install imageoptim
install iterm2
install licecap
install mactracker
install sketch
install skype
install slack
install hammerspoon
install spotify
install sublime-text3
install telegram
install torbrowser
install transmission
install virtualbox
install vlc
install zeplin
install screenhero

# Tap homebrew cask fonts to enable installation of binary font files
brew tap caskroom/fonts

# Install fonts
install font-cabin
install font-fira-sans
install font-lato
install font-merriweather
install font-merriweather-sans
install font-montserrat
install font-open-sans
install font-oxygen
install font-pt-sans
install font-pt-serif
install font-quattrocento-sans
install font-roboto
install font-source-sans-pro
install font-source-serif-pro
install font-varela
install font-varela-round
install font-inconsolata

# Remove outdated versions from the cellar
brew cleanup
brew cask cleanup

unset -f install
