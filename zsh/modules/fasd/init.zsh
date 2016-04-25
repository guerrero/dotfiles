#
# Maintains a frequently used file and directory list for fast access.
#
# Authors:
#   Wei Dai <x@wei23.net>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Load dependencies.
pmodload 'editor'

# Return if requirements are not found.
if (( ! $+commands[fasd] )); then
  return 1
fi

#
# Tweaks
#

if [[ ! -d $HOME/.cache/fasd ]]; then
  mkdir -p "$HOME/.cache/fasd"
fi

export _FASD_DATA="$HOME/.cache/fasd/data"

#
# Initialization
#

eval "$(fasd --init auto)"

#
# Aliases
#

#
# Maintains a frequently used file and directory list for fast access.
#
# Authors:
#   Wei Dai <x@wei23.net>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Load dependencies.
# pmodload 'editor'

# Return if requirements are not found.
if (( ! $+commands[fasd] )); then
  return 1
fi

#
# Tweaks
#

if [[ ! -d $HOME/.cache/fasd ]]; then
  mkdir -p "$HOME/.cache/fasd"
fi

export _FASD_DATA="$HOME/.cache/fasd/data"

#
# Initialization
#

eval "$(fasd --init auto)"

#
# Aliases
#

alias fe='f -e vim'

# Changes the current working directory interactively.
alias j='fasd_cd -i'
