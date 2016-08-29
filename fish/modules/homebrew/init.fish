#
# Defines Homebrew aliases.
#

# Return if requirements are not found.
if not test (uname) = 'Darwin'
  or not type -q brew
  exit
end

#
# Aliases
#

# Homebrew Cask
alias cask='brew cask'
