#
# Global config for Fish shell
#

if test (uname) = 'Darwin'
  set -U BROWSER 'open'
end

#
# Editors
#

if type -q atom
  set -U EDITOR 'atom'
else if type -q subl
  set -U EDITOR 'subl'
else
  set -U EDITOR 'vim'
end

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
