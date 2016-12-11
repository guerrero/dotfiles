#
# Provides Git aliases and functions.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Return if requirements are not found.
if not type -q go
  exit
end

#
# Aliases
#

# Git
alias g 'git'
alias gitc 'git commit --verbose'
