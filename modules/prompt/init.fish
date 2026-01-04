#
# Initialize Starship prompt for fish shell.
#

# Avoid config if requirements are not found.
if not type -q starship
  exit
end

# Initialize starship
starship init fish | source
