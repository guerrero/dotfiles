#!/usr/bin/env bash

# Install binary packages using Homebrew (http://brew.sh)

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure we're using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Replace outdated GNU utilities that come with OS X
# Add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`
# to use them without prefixes
brew install coreutils --default-names
brew install findutils --default-names

# Install wget with IRI support
brew install wget --enable-iri

# Install more recent versions of some OS X tools
brew install vim --with-lua --override-system-vi
brew install homebrew/dupes/grep

# Install everything else
brew install tmux
brew install fasd
brew install git
brew install git-extras
brew install node
brew install rename
brew install tree
brew install go
# brew install hub

# Remove outdated versions from the cellar
brew cleanup

# Check if installation is successfully
brew doctor