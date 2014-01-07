#!/usr/bin/env bash

caskfile=$DOTFILES/brew/Caskfile
brewfile=$DOTFILES/brew/Brewfile

# Upgrade homebrew
brew update

# Update homebrew formulas
brew upgrade

# Install formulas
brew bundle $Caskfile
brew bundle $Brewfile