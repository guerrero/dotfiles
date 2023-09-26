# Quicker navigation (.. is included by default in Fish)
abbr -a ... "cd ../.."
abbr -a .... "cd ../../.."
abbr -a ..... "cd ../../../.."

# Directories
abbr -a docs "cd $HOME/Documents"
abbr -a dl "cd $HOME/Downloads"
abbr -a dt "cd $HOME/Desktop"
abbr -a ws "cd $HOME/Workspace"

#List
abbr -a lsdir 'ls -lF {$colorflag} | grep "^d"'
abbr -a ll "ls -alGh"
abbr -a ls "ls -Gh"
abbr -a df "df -h"
abbr -a du "du -h -d 2"

# Common shell functions
abbr -a tf 'tail -f'
abbr -a lh 'ls -alt | head' # see the last modified files
abbr -a cl 'clear'

# Compress files
abbr -a gz 'tar -zcvf'
