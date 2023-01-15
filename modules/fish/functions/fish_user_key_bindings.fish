# Grabbed from Aerys Bat's implementation
# 
# More info: https://github.com/fish-shell/fish-shell/wiki/Bash-Style-Command-Substitution-and-Chaining-(!!-!$)
function fish_user_key_bindings
  bind ! bind_bang
  bind '$' bind_dollar
end
