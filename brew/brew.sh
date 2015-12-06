#!/usr/bin/env bash

# Install binary packages using Homebrew (http://brew.sh)

# Make sure we're using the latest Homebrew
brew update

# Install wget with IRI support
brew install wget --with-iri

# Install more recent version of vim
brew install vim --with-lua --override-system-vi

# Install everything else
brew install duti
brew install fasd
brew install gist
brew install git
brew install go
brew install hub
brew install mongodb
brew install node
brew install postgresql
brew install tree
brew install unrar

# Install OpenCV
brew install homebrew/science/opencv

# Remove outdated versions from the cellar
brew cleanup
