#!/usr/bin/env bash

# Local aliases

# Global aliases
DOT_CASKFILE_PATH="$DOTFILES/brew/Caskfile"

cask() {

  # Dependencies

  # Options
	case "$1" in
    setup)
      cask_setup
    ;;

    install)
      cask_install "$@"
    ;;

    uninstall)
      cask_uninstall "$@"
    ;;

    bundle)
      cask_bundle "$DOT_CASKFILE_PATH"
    ;;

    help)
      cask_help "$@"
    ;;

    *)
      brew cask "$@"
    ;;
  esac
}

cask_help() {
	echo "Homebrew cask help"
}

cask_setup() {

  # Generate Caskfile if it doesn't exists
  if [ ! -s "$DOT_CASKFILE_PATH" ]; then
    mkdir -p "$( dirname "$DOT_CASKFILE_PATH" )"
    touch "$DOT_CASKFILE_PATH"

    # Add some text to Caskfile
    cat <<EOF > "$DOT_CASKFILE_PATH"
# Update Homebrew
update

# Install Homebrew Cask
install caskroom/cask/brew-cask
EOF
  else
    echo "There is already a Caskfile into $DOT_CASKFILE_PATH"
  fi
}

cask_install() {

  shift

  casks=()
  savecask=true
  appdir=false

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
        if grep -q "$var" "$DOT_CASKFILE_PATH"; then
          echo "$var is already place into Caskfile"
        else
          echo -n -e "\ncask install $var" >> "$DOT_CASKFILE_PATH"
        fi
      fi
    fi
    brew cask install "$var"
  done

  unset casks
  unset savecask
  unset appdir
}

cask_uninstall() {

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
      if grep -q "$var" "$DOT_CASKFILE_PATH"; then
        echo -n -e "\ncask install $var" >> "$DOT_CASKFILE_PATH"
      else
        echo "$var is not place into Caskfile"
      fi
    fi
    brew cask uninstall "$var"
  done

  unset removecask
  unset casks
}