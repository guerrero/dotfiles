#
# Loads the Node Version Manager
#

# Return if requirements are not found.
if not type -q node; and not brew list | grep -q "nvm"
  exit
end

# Load package manager installed NVM into the shell session.
if type -q brew; and test -f (brew --prefix nvm)/nvm.sh

  mkdir -p "$HOME/.nvm"
  and set -x NVM_DIR "$HOME/.nvm"

  function nvm
    bass source (brew --prefix nvm)/nvm.sh --no-use ';' nvm $argv
  end
end
