
#
# Loads the Node Version Manager
#

# Return if requirements are not found.
if not type -q node; and not brew list pnpm &>/dev/null;
  exit
end

if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
