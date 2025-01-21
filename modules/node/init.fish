
#
# Loads the Node Version Manager
#

# Return if requirements are not found.
if not type -q node; and not brew list pnpm &>/dev/null;
  exit
end

set -gx PNPM_HOME "$HOME/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
