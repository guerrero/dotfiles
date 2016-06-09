#
# Global config for Fish shell
#

if test (uname) = 'Darwin'
  set -U BROWSER 'open'
end

#
# Editors
#

set -U EDITOR 'vim'
set -U VISUAL 'vim'
set -U PAGER 'less'

#
# Language
#

if test -z "$LANG"
  set -U LANG 'en_US.UTF-8'
end

#
# Paths
#

# Set the list of directories
set -x PATH /usr/local/bin $PATH

#
# Init modules
#

for path in ~/.dotfiles/fish/modules/*/init.fish
  source $path
end
