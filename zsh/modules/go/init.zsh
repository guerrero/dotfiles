#
# Sets $GOPATH for golang and add go binaries to $path
#
# Authors:
#   Alex Guerrero
#

# Return if requirements are not found.
if (( ! $+commands[go] )); then
  return 1
fi

# Set GOPATH to my workspace location and append Go binaries to PATH
if [[ "$OSTYPE" == darwin* && -d "$HOME/.golang" ]]; then
  export GOPATH=$HOME/.golang
  path=($path $GOPATH/bin)
fi
