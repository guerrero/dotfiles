#
# Provides Git abbreviations.
#

# Return if requirements are not found.
if not type -q git
  exit
end

abbr -a g 'git'
abbr -a gs 'git status'
abbr -a gd 'git diff'
abbr -a gc 'git commit'
abbr -a gcp 'git commit --patch'
abbr -a gca 'git commit --amend'
abbr -a gcm 'git commit --message'
abbr -a gcma 'git commit --amend --message'
abbr -a gco 'git checkout'
abbr -a gp 'git push'
abbr -a gitc 'git commit --verbose'
abbr -a gl 'git log --graph --oneline --decorate --all'
abbr -a glog 'git log'