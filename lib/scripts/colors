# Notice title
notice() { echo "\033[1;32m=> $1\033[0m"; }

# Error title
error() { echo "\033[1;31m=> Error: $1\033[0m"; }

# List item
c_list() { echo " \033[1;32m✔\033[0m $1"; }

# Error list item
e_list() { echo " \033[1;31m✖\033[0m $1"; }


# Color errors in make output (or make-like output)
ccred=$(echo -e "\033[1;31m")
ccend=$(echo -e "\033[0m")
$@ 2>&1 | sed "s/error:/${ccred}error:${ccend}/"

DOTFILES_ROOT="`pwd`"

set -e

echo ''

info () {
  printf "  [ \033[00;34m..\033[0m ] $1"
}

user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}