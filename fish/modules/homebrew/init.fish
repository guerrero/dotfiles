#
# Defines Homebrew aliases.
#

# Return if requirements are not found.
if test (uname) = 'Darwin'
  and type -q brew
  exit
end


#
# Tweaks
#

# Place Homebrew-Cask app links into /Applications by default
set -x HOMEBREW_CASK_OPTS "--appdir=/Applications"


#
# Aliases
#

# Homebrew Cask
alias cask='brew cask'
