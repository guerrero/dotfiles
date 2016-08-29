#!/usr/bin/env bash

# Install apps using Homebrew-Cask (http://caskroom.io/)

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until `cask.sh` has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Update Homebrew to ensure we are using the latest Homebrew-cask version
brew update

declare -a repositories=(
  caskroom/cask # Repository for applications
  caskroom/versions # Repository for alternate app versions
  caskroom/fonts # Repository for binary font files
)

declare -a casks=(
  java6 # Install Java 6 required by some apps
  silverlight # Install Silverlight required by Netflix

  alfred
  atom
  chromium
  clamxav
  cleanmymac
  cyberduck
  dash
  firefox
  google-chrome
  google-hangouts
  hammerspoon
  imageoptim
  iterm2
  licecap
  mactracker
  screenhero
  sketch
  skype
  slack
  spotify
  sublime-text
  telegram
  torbrowser
  transmission
  virtualbox
  vlc
  zeplin

  font-cabin
  font-fira-sans
  font-lato
  font-merriweather
  font-merriweather-sans
  font-montserrat
  font-open-sans
  font-oxygen
  font-pt-sans
  font-pt-serif
  font-quattrocento-sans
  font-roboto
  font-source-sans-pro
  font-source-serif-pro
  font-varela
  font-varela-round
  font-inconsolata
)

# Add repositories to Homebrew
for repository in "${repositories[@]}"; do
  repository_name="${repository##*/}"

  if ! brew tap | grep -q $repository_name; then
    echo -e "\e[32m==>\e[0m Adding ${repository_name} to Homebrew..."
    brew tap $repository
  else
    echo -e "\e[33m\e[4mWarning\e[0m: Repository ${repository_name} has been added previously."
  fi
done

# Install apps from Casks
for cask in "${casks[@]}"; do
  if ! brew cask list | grep -q $cask; then
    echo -e "\e[32m==>\e[0m Installing ${cask}..."
    brew cask install $cask
  else
    echo -e "\e[33m\e[4mWarning\e[0m: A Cask for ${cask} is already installed."
  fi
done

# Remove outdated versions from the cellar
brew cleanup
brew cask cleanup

unset repositories casks
