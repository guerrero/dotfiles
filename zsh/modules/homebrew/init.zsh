#
# Defines Homebrew aliases.
#

# Return if requirements are not found.
if [[ "$OSTYPE" != darwin* ]] && (( ! $+commands[brew] )); then
  return 1
fi


#
# Tweaks
#

# Place Homebrew-Cask app links into /Applications by default
export HOMEBREW_CASK_OPTS="--appdir=/Applications"


#
# Aliases
#

# Homebrew
alias brewc='brew cleanup'
alias brewC='brew cleanup --force'
alias brewi='brew install'
alias brewl='brew list'
alias brews='brew search'
alias brewu='brew upgrade'
alias brewU='brew update && brew upgrade'
alias brewx='brew remove'

# Homebrew Cask
alias cask='brew cask'
alias caskc='brew cask cleanup --outdated'
alias caskC='brew cask cleanup'
alias caski='brew cask install'
alias caskl='brew cask list'
alias casks='brew cask search'
alias caskx='brew cask uninstall'
