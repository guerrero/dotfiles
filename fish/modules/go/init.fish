#
# Sets $GOPATH for golang and add go binaries to $path
#

# Avoid config if requirements are not found.
if type -q go and test (uname) = 'Darwin' and not test -d "$HOME/.golang"
  exit
end

# Set GOPATH to my workspace location and append Go binaries to PATH
set -x GOPATH "$HOME/.golang"
set -x PATH $PATH "$GOPATH/bin"
