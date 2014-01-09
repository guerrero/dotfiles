# why would you type 'cd dir' if you could just type 'dir'?
setopt auto_cd

# If the argument to a cd command (or an implied cd with the AUTO_CD option set) is not a directory, and does not begin with a slash, try to expand the expression as if it were preceded by a '~' (see the section 'Filename Expansion'). 
setopt cdable_vars

# When changing to a directory containing a path segment '..' which would otherwise be treated as canceling the previous segment in the path (in other words, 'foo/..' would be removed from the path, or if '..' is the first part of the path, the last part of $PWD would be deleted), instead resolve the path to the physical directory
setopt chase_dots

# Resolve symbolic links to their true values when changing directory
setopt chase_links

# Don't push multiple copies of the same directory onto the directory stack
setopt pushd_ignore_dups

# Have pushd with no arguments act like 'pushd $HOME'
setopt pushd_to_home

# Exchanges the meanings of '+' and '-' when used with a number to specify a directory in the stack
setopt pushd_minus

# Automatically list choices on an ambiguous completion. (default)
setopt auto_list

# This will use named dirs when possible
setopt auto_name_dirs

# I like annoying pushd messages...
setopt no_pushd_silent

# 10 second wait if you do 'rm *' or 'rm path/*'.
setopt rm_star_wait

# use zsh line editor (this is default, but it can't hurt!)
setopt zle

# Allow comments even in interactive shells
setopt interactive_comments

# Beeps are annoying
setopt no_beep

# Do not exit on end-of-file
setopt ignore_eof

# Don't expand aliases _before_ completion has finished
setopt complete_aliases

# Disable output flow control in shell's editor via start/stop characters (^S/^Q) 
setopt no_flow_control

# Treat the '#', '~' and '^' as part of patterns for filename generation
setopt extended_glob

# If numeric filenames are matched by a filename generation pattern, sort the filenames numerically rather than lexicographically. 
setopt numeric_glob_sort

# TEST:

# Now we can pipe to multiple outputs!
# setopt multios

# Don't nice background tasks
# setopt no_bg_nice

# ???
# setopt complete_in_word

# If we have a glob this will expand it
# setopt glob_complete

# Why???
# setopt no_hup

# Fuck
# setopt exec

# Fuck
# setopt function_argzero

# hows about arrays be awesome?  (that is, frew${cool}frew has frew surrounding all the variables, not just first and last
# setopt rc_expand_param

# Fuck
# setopt correct