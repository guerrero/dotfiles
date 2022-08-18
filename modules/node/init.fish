
#
# Loads the Node Version Manager
#

# Return if requirements are not found.
if not type -q node; and not brew list nvm &>/dev/null;
  exit
end

set nvm_binary (echo (brew --prefix nvm)/nvm.sh)

# Load NVM package manager installed into the shell session.
if type -q brew; and test -f $nvm_binary

  mkdir -p "$HOME/.nvm"
  and set -x NVM_DIR "$HOME/.nvm"

  function nvm
    bass source $nvm_binary --no-use ';' nvm $argv
  end
end
