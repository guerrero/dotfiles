#
# Maintains a frequently used file and directory list for fast access.
#

# Avoid config if requirements are not found.
if not type -q fasd
  exit
end

#
# Tweaks
#

# Change fasd data dir
set -x _FASD_DATA "$HOME/.cache/fasd/data"

#
# Aliases
#

alias vimf 'f -e vim' # Search files with fasd and then open them with vim
