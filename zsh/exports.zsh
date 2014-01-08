# Make Sublime Text the default editor
export EDITOR="subl"

# Prefer US English and use UTF-8
export LANG="en_US"
export LC_ALL="en_US.UTF-8"

# Highlight section titles in manual pages
export LESS_TERMCAP_md="$ORANGE"

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto"

# IMPORTANT
# Link Homebrew casks in `/Applications` rather than `~/Applications`
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

export MATHPATH="$MANPATH:/usr/local/texlive/2007/texmf/doc/man"
export INFOPATH="$INFOPATH:/usr/local/texlive/2007/texmf/doc/info"
export PATH="$PATH:/usr/local/texlive/2007/bin/i386-linux"
export RI="--format ansi"

declare -U path

#export LANG=en_US
export PAGER=most
#}}}]

# path, the 0 in the filename causes this to load first
export PATH=$PATH:$HOME/.yadr/bin:$HOME/.yadr/bin/yadr

export PATH="./bin:$HOME/.rbenv/shims:/usr/local/bin:/usr/local/sbin:$HOME/.sfs:$ZSH/bin:$PATH"

export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"


# APPLE, put /usr/bin before /usr/local/bin?!
PATH=/usr/local/bin:$(path_remove /usr/local/bin)
export PATH

# Add paths that should have been there by default
export PATH=${PATH}:/usr/local/bin
export PATH="~/bin:$PATH"
export PATH="$PATH:~/.gem/ruby/1.8/bin"

# Add postgres to the path
export PATH=$PATH:/usr/local/pgsql/bin
export PATH=$PATH:/Library/PostgreSQL/8.3/bin

# Add paths
export PATH=/usr/local/sbin:/usr/local/bin:${PATH}
export PATH="$HOME/bin:$PATH"

# By default, zsh considers many characters part of a word (e.g., _ and -).
# Narrow that down to allow easier skipping through words via M-f and M-b.
export WORDCHARS='*?[]~&;!$%^<>'

# Highlight search results in ack.
export ACK_COLOR_MATCH='red'


# Initialize RVM
PATH=$PATH:$HOME/.rvm/bin
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

if [[ -n $SSH_CONNECTION ]]; then
  export PS1='%m:%3~$(git_info_for_prompt)%# '
else
  export PS1='%3~$(git_info_for_prompt)%# '
fi


# Defines environment variables.
privenv="$HOME/.private-env"
[[ -f "$privenv" ]] && source $privenv

# Browser.
# --------
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

# Editors.
# --------
export EDITOR='/usr/local/bin/subl'
export VISUAL='/usr/local/bin/subl'
export PAGER='less'

# Language.
# ---------
if [[ -z "$LANG" ]]; then
  eval "$(locale)"
fi

# Less.
# -----
# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
if (( $+commands[lesspipe.sh] )); then
  export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
fi

# Paths.
# ------
typeset -gU cdpath fpath mailpath manpath path
typeset -gUT INFOPATH infopath

# Commonly used directories.
dev="$HOME/Development"
br="$dev/brunch"
ch="$dev/chaplinjs"
com="$dev/com"
pm="$dev/paulmillr"
as="$HOME/Library/Application Support"

# Set the the list of directories that cd searches.
cdpath=(
  $cdpath
)

# Set the list of directories that info searches for manuals.
infopath=(
  /usr/local/share/info
  /usr/share/info
  $infopath
)

# Set the list of directories that man searches for manuals.
manpath=(
  /usr/local/share/man
  /usr/share/man
  $manpath
)

for path_file in /etc/manpaths.d/*(.N); do
  manpath+=($(<$path_file))
done
unset path_file

# Set the list of directories that Zsh searches for programs.
export PYTHONPATH=/usr/local/lib/python2.7/site-packages
path=(
  /usr/local/{bin,sbin}
  /usr/local/lib/python2.7/site-packages
  /usr/local/share/npm/bin
  /usr/{bin,sbin}
  /{bin,sbin}
  $path
)

for path_file in /etc/paths.d/*(.N); do
  path+=($(<$path_file))
done
unset path_file

# Temporary Files.
if [[ -d "$TMPDIR" ]]; then
  export TMPPREFIX="${TMPDIR%/}/zsh"
  if [[ ! -d "$TMPPREFIX" ]]; then
    mkdir -p "$TMPPREFIX"
  fi
fi

export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

export NODE_PATH='/usr/local/lib/node_modules'

# only fools wouldn't do this ;-)
export EDITOR="vi"