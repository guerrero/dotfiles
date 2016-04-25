#
# Initializes Prezto.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#
# Version Check
#

# Check for the minimum supported version.
min_zsh_version='4.3.17'
if ! autoload -Uz is-at-least || ! is-at-least "$min_zsh_version"; then
  print "zsh: old shell detected, minimum required: $min_zsh_version" >&2
  return 1
fi
unset min_zsh_version

#
# Module Loader
#

# Loads Prezto modules.
function pmodload {
  local -a pmodules
  local pmodule
  local pfunction_glob='^([_.]*|prompt_*_setup|README*)(-.N:t)'

  # $argv is overridden in the anonymous function.
  pmodules=("$argv[@]")

  # Add functions to $fpath.
  fpath=(${pmodules:+${ZDOTDIR:-$HOME}/.dotfiles/zsh/modules/${^pmodules}/functions(/FN)} $fpath)

  function {
    local pfunction

    # Extended globbing is needed for listing autoloadable function directories.
    setopt LOCAL_OPTIONS EXTENDED_GLOB

    # Load Prezto functions.
    for pfunction in ${ZDOTDIR:-$HOME}/.dotfiles/zsh/modules/${^pmodules}/functions/$~pfunction_glob; do
      autoload -Uz "$pfunction"
    done
  }

  # Load Prezto modules.
  for pmodule in "$pmodules[@]"; do
    if zstyle -t ":zsh:module:$pmodule" loaded 'yes' 'no'; then
      continue
    elif [[ ! -d "${ZDOTDIR:-$HOME}/.dotfiles/zsh/modules/$pmodule" ]]; then
      print "$0: no such module: $pmodule" >&2
      continue
    else
      if [[ -s "${ZDOTDIR:-$HOME}/.dotfiles/zsh/modules/$pmodule/init.zsh" ]]; then
        source "${ZDOTDIR:-$HOME}/.dotfiles/zsh/modules/$pmodule/init.zsh"
      fi

      if (( $? == 0 )); then
        zstyle ":zsh:module:$pmodule" loaded 'yes'
      else
        # Remove the $fpath entry.
        fpath[(r)${ZDOTDIR:-$HOME}/.dotfiles/zsh/modules/${pmodule}/functions]=()

        function {
          local pfunction

          # Extended globbing is needed for listing autoloadable function
          # directories.
          setopt LOCAL_OPTIONS EXTENDED_GLOB

          # Unload Prezto functions.
          for pfunction in ${ZDOTDIR:-$HOME}/.dotfiles/zsh/modules/$pmodule/functions/$~pfunction_glob; do
            unfunction "$pfunction"
          done
        }

        zstyle ":zsh:module:$pmodule" loaded 'no'
      fi
    fi
  done
}

#
# Prezto Initialization
#

# Disable color and theme in dumb terminals.
if [[ "$TERM" == 'dumb' ]]; then
  zstyle ':zsh:*:*' color 'no'
fi

# Load Zsh modules.
zstyle -a ':zsh:load' zmodule 'zmodules'
for zmodule ("$zmodules[@]") zmodload "zsh/${(z)zmodule}"
unset zmodule{s,}

# Autoload Zsh functions.
zstyle -a ':zsh:load' zfunction 'zfunctions'
for zfunction ("$zfunctions[@]") autoload -Uz "$zfunction"
unset zfunction{s,}

# Load Prezto modules.
zstyle -a ':zsh:load' pmodule 'pmodules'
pmodload "$pmodules[@]"
unset pmodules
