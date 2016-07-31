#
# Sets $GOPATH for golang and add go binaries to $path
#

# Avoid config if requirements are not found.
if not type -q go; or test (uname) != 'Darwin'; or not test -d "$HOME/.golang"
  exit
end

# Set GOPATH to my workspace location
set -x GOPATH "$HOME/.golang"

# Append Go binaries to PATH
if test -d "$GOPATH/bin"
  set -x PATH $PATH "$GOPATH/bin"
end
