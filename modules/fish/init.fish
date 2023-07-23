# Quicker navigation (.. is included by default in Fish)
alias ... "cd ../.."
alias .... "cd ../../.."
alias ..... "cd ../../../.."

# Directories
alias docs "cd $HOME/Documents"
alias dl "cd $HOME/Downloads"
alias dt "cd $HOME/Desktop"
alias ws "cd $HOME/Workspace"

#List aliases
alias lsdir 'ls -lF {$colorflag} | grep "^d"'
alias ll "ls -alGh"
alias ls "ls -Gh"
alias df "df -h"
alias du "du -h -d 2"

# Common shell functions
alias tf 'tail -f'
alias lh 'ls -alt | head' # see the last modified files
alias cl 'clear'

# Compress files aliases
alias gz='tar -zcvf'
