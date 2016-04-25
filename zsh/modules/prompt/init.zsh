#
# Loads prompt themes.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Load and execute the prompt theming system.
autoload -Uz promptinit && promptinit

# Load the prompt theme.
if [[ "$TERM" == (dumb|linux|*bsd*) ]]; then
  prompt 'off'
else
  prompt custom
fi
