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

# Create fasd data dir if it's not already created
mkdir -p "$HOME/.cache/fasd"

# Change fasd data dir
set -x _FASD_DATA "$HOME/.cache/fasd/data"

#
# Abbreviations
#

abbr -a oc 'fasd -a -e code' # find files/dirs with fasd and open them in VS Code
