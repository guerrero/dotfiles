#
# Provides Git aliases and functions.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Return if requirements are not found.
if not type -q git
  exit
end

#
# Aliases
#

# Git
abbr g 'git'
abbr gd 'git diff'
abbr gc 'git commit'
abbr gcp 'git commit --patch'
abbr gca 'git commit --amend'
abbr gcm 'git commit --message'
abbr gcam 'git commit --amend --message'
abbr gco 'git checkout'
abbr gp 'git push'
abbr gitc 'git commit --verbose'
abbr gl 'git log --graph --oneline --decorate --all'
abbr glog 'git log'