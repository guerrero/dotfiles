#!/usr/bin/env bash

dot_bootstrap() {

  DOTFILES_ROOT="`pwd`"

  # Apply set -e when this works well

  # Ask for the administrator password upfront
  sudo -v

  # Keep-alive: update existing `sudo` time stamp until `.bootstrap` has finished
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

  # Update files
  source update-dotfiles

  # Set names for computer, host, localhost and NetBios
  echo 'Enter new name of the machine (e.g. my-sweet-macbook)'
    read computername
    echo "Setting computer name to $compname..."
      sudo scutil --set ComputerName "$compname"
      sudo scutil --set HostName "$compname"
      sudo scutil --set LocalHostName "$compname"
      sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$compname"

  # TODO: Check if SSH key is set and Ask for setting SSH key a
  echo 'Checking for SSH key, generating one if it does not exist...'
    [[ -f '~/.ssh/id_rsa.pub' ]] || ssh-keygen -t rsa

  echo 'Copying public key to clipboard. Paste it into your Github account...'
    [[ -f '~/.ssh/id_rsa.pub' ]] && cat '~/.ssh/id_rsa.pub' | pbcopy
    open 'https://github.com/account/ssh'

  # Create my folders or import from backup
  # Move from backup?
  # Create folders?

  # Run the appropiate OS installation
  if [ "$(uname -s)" == "Darwin" ]; then
    source install-osx
  elif [ "$(uname -s)" == "Linux" ]; then
    source install-ubuntu
  fi

  echo "Setting gitignore global file..."
  git config --global core.excludesfile ~/.gitignore

  echo 'Symlinking config files...'
    source symlink-dotfiles.sh

   # Add binaries into the path
  PATH=~/.dotfiles/bin:$PATH
  PATH=~/.dotfiles/scripts:$PATH
  export PATH

  # Use zsh in shell if it's not already in use
  [ "$(echo $SHELL)" == "/bin/zsh" ] || chsh -s /bin/bash

  echo 'Done!'

  setup_gitconfig
  install_dotfiles
}