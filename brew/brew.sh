#!/usr/bin/env bash

# Install binary packages using Homebrew (http://brew.sh)

# Make sure we're using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

# Install wget with IRI support
brew install wget --with-iri

# Install more recent version of vim
brew install vim --with-lua --override-system-vi

# Install everything else
brew install fasd
brew install git
brew install gist
brew install go
brew install node
brew install iojs
brew install python3
brew install tree
brew install hub

# Install OpenCV
brew install homebrew/science/opencv

# Check if installation is successfully
brew doctor

# Remove outdated versions from the cellar
brew cleanup
