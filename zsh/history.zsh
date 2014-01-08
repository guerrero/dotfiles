# TODO:
# Enable setopt HISTTIMEFORMAT?
# Check if SAVEHIST is necessary
# Try INC_APPEND_HISTORY with multiple Terminal windows open
# Check if append_history is necessary even declared inc_append_history
# test hist_no_store option
# Check if HISTTIMEFORMAT is necessary or works with extended history
# Check if is necessary hist_find_no_dups even if hist_ignore_all_dups is set

## Command history configuration
if [ -z $HISTFILE ]; then
  # Where it gets saved
  HISTFILE=$HOME/.zsh_history
fi

# Store 10k history entries
# Reference: http://stackoverflow.com/questions/19454837/bash-histsize-vs-histfilesize)
export HISTSIZE=10000
export HISTFILESIZE=10000

# export HISTFILE=$HOME/.zsh_history
export SAVEHIST=$HISTSIZE

# Make some commands not show up in history
export HISTIGNORE="ls:cd -:pwd:exit:date:* --help"

# Give history timestamps.
export HISTTIMEFORMAT="[%F %T] "

# Zsh options
# Reference: http://linux.die.net/man/1/zshoptions

# Don't record duplicated commands in history (all = even if it is not the previous event, remove it if undesired behaviour)
setopt hist_ignore_all_dups 

# Remove superfluous blanks from each command line being added to the history list
setopt hist_reduce_blanks

# add timestamps to history
setopt extended_history

# When using a hist thing, make a newline show the change before executing it.
setopt hist_verify

# Killer: share history between multiple shells, if specified it likes inc_append_history and extended_history are set so they are unnecesary check set_local_history zle binding
# If you find that you want more control over when commands get imported, you may wish to turn SHARE_HISTORY off, INC_APPEND_HISTORY on, and then manually import commands whenever you need them using 'fc -RI'. 
setopt share_history 

# Whenever the user enters a line with history expansion, don't execute the line directly; instead, perform history expansion and reload the line into the editing buffer.
setopt hist_verify

# Remove the history (fc -l) command from the history list when invoked.
# Note that the command lingers in the internal history until the next
# command is entered before it vanishes, allowing you to briefly reuse or edit the line. 
setopt hist_no_store

# Save each command's beginning timestamp (in seconds since the epoch) and the duration (in seconds) to the history file
# setopt extended_history

# Don't overwrite history, append! Save every command before it is executed 
# setopt inc_append_history 