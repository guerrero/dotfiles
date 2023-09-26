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
abbr -a bi 'brew install'
abbr -a bic 'brew install --cask'
abbr -a bup 'brew upgrade'
abbr -a bl 'brew list'
abbr -a bs 'brew search --cask'
abbr -a bsc 'brew search --cask'
