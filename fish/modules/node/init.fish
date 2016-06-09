#
# Loads the Node Version Manager and enables npm completion.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Zeh Rizzatti <zehrizzatti@gmail.com>
#

# Return if requirements are not found.
if type -q node
  exit
end

# Load package manager installed NVM into the shell session.
if type -q brew and type -q nvm
  source (brew --prefix nvm)/nvm.sh
end
