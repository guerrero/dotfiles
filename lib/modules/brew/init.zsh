#!/usr/bin/env bash

# Local aliases

# Global aliases
DOT_BREWFILE_PATH="$DOTFILES/brew/Brewfile"

cask() {

  # Dependencies

  # Options
	case "$1" in
    setup)
      brew_setup
    ;;

    install)
      brew_install "$@"
    ;;

    uninstall)
      brew_uninstall "$@"
    ;;

    bundle)
      brew bundle "$DOT_BREWFILE_PATH"
    ;;

    help)
      brew_help "$@"
    ;;

    *)
      brew "$@"
    ;;
  esac
}

brew_help() {
	echo "Homebrew cask help"
}

brew_setup() {

  # Generate Caskfile if it doesn't exists
  if [ ! -s "$DOT_BREWFILE_PATH" ]; then
    mkdir -p "$( dirname "$DOT_BREWFILE_PATH" )"
    touch "$DOT_BREWFILE_PATH"

    # Add some text to Caskfile
    cat <<EOF > "$DOT_BREWFILE_PATH"
# Update Homebrew
update

# Install Homebrew Cask
install caskroom/cask/brew-cask
EOF
  else
    echo "There is already a Caskfile into $DOT_BREWFILE_PATH"
  fi
}

brew_install() {

  shift

  formulas=()
  saveformula=true

  for var in "$@"; do
    case $var in
      "--app-dir="*)
        appdir="${var}"
      ;;
      "-n")
        savecask=false
      ;;
      *)
        casks+=("$var")
      ;;
    esac
  done
  echo "$casks"
  for var in "$casks"; do
    echo "$var"
    if [ "$(brew cask search $var)" == "No cask found for \"$var\"." ]; then
      echo "No cask found for $var."
    else
      if [ $savecask ]; then
        if grep -q "$var" "$DOT_BREWFILE_PATH"; then
          echo "$var is already place into Caskfile"
        else
          echo -n -e "\nbrew install $var" >> "$DOT_BREWFILE_PATH"
        fi
      fi
    fi
    brew cask install "$var"
  done

  unset casks
  unset savecask
  unset appdir
}

brew_uninstall() {

  shift

  casks=()
  removecask=true

  for var in "$@"; do
    case $var in
      "-m")
        removecask=false
      ;;
      *)
        casks+=("$var")
      ;;
    esac
  done
  echo "$casks"
  for var in "$casks"; do
    echo "$var"
    if [ $removecask ]; then
      if grep -q "$var" "$DOT_BREWFILE_PATH"; then
        echo -n -e "\ncask install $var" >> "$DOT_BREWFILE_PATH"
      else
        echo "$var is not place into Caskfile"
      fi
    fi
    brew cask uninstall "$var"
  done

  unset removecask
  unset casks
}