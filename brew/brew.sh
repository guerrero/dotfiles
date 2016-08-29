#!/usr/bin/env bash

# Install binary packages using Homebrew (http://brew.sh)

# Make sure we're using the latest Homebrew
brew update

declare -a formulas=(
  duti
  elixir
  elm
  erlang
  fasd
  fish
  gist
  git
  go
  homebrew/science/opencv
  hub
  lua
  mongodb
  node
  nvm
  postgresql
  python
  rust
  tree
  unrar
  "vim --with-lua --override-system-vi" # recent version of vim
  "wget --with-iri" # Install wget with IRI support
  youtube-dl
)

# Install binaries from Homebrew formulas
for formula in "${formulas[@]}"; do
  formula_wo_spaces="${formula%% *}"
  formula_name="${formula_wo_spaces##*/}"

  if ! brew list | grep -q "$formula_name"; then
    echo -e "\e[32m==>\e[0m Installing $formula_name..."
    brew install $formula
  else
    echo -e "\e[33m\e[4mWarning\e[0m: A formula for $formula_name is already installed."
  fi
done

# Remove outdated versions from the cellar
brew cleanup

unset formulas formula_name
