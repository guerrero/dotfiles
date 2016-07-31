#
# Global config for Fish shell
#

if test (uname) = 'Darwin'
  set -U BROWSER 'open'
end

#
# Editors
#

if type -q subl
  set -U EDITOR 'subl'
else if type -q atom
  set -U EDITOR 'atom'
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

set -l current_dirname (dirname (status -f))

for path in ~/.dotfiles/fish/modules/*

  if test -e $path/init.fish
    source $path/init.fish
  end

  for module_function in $path/functions/*
    ln -s -f $module_function $current_dirname'/functions'
  end

end
