#!/usr/bin/env zsh


dot() {
source "$DOTFILES/lib/modules/cask/init.zsh"
$@
}


dot_load_core_modules() {
  for coremodule in "$HOME/Dev/dotfiles/lib/core/$*"; do
    source coremodule
  done
}