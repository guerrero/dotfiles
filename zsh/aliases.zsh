### Aliases

# Quicker navigation
alias --="cd -"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Super user
alias _='sudo'
alias please='sudo'

# Reload zsh config
alias reload!='source ~/.zshrc'

# Open specified files in Sublime Text
alias e="subl"
function cded() {
    cd $1
    $EDITOR .
  }

# Directories
alias docs="cd ~/Documents"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="cd ~/Proyectos"
alias code="cd ~/Dev"

# Time aliases
alias week='date +%V'

# History
alias history='fc -l 1'

# Easily re-execute the last history command.
alias r="fc -s"

#List aliases
alias lsdir='ls -lF ${colorflag} | grep "^d"'
alias ll='ls -alGh'
alias ls='ls -Gh'
alias df='df -h'
alias du='du -h -d 2'
alias sl=ls # often screw this up
if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi
# Directory listing
if [[ "$(type -P tree)" ]]; then
alias ll='tree --dirsfirst -aLpughDFiC 1'
  alias lsd='ll -d'
else
alias ll='ls -al'
  alias lsd='CLICOLOR_FORCE=1 ll | grep --color=never "^d"'
fi

# Edit dotfiles
alias ar='subl $DOTFILES/zsh/aliases.zsh'
alias ze='subl ~/.zshrc'


# Common shell functions
alias tf='tail -f'
alias lh='ls -alt | head' # see the last modified files
alias cl='clear'

# Compress files aliases
alias gz='tar -zcvf'

# OSX-specific Git shortcuts
if [[ "$OSTYPE" =~ ^darwin ]]; then

  alias ls="command ls -G"

  # Lock the screen (when going AFK)
  alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
  # Start ScreenSaver. This will lock the screen if locking is enabled.
  alias ss="open /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app"
    
  # Clean up LaunchServices to remove duplicates in the “Open With” menu
  alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

  # Merge PDF files
  # Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
  alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'

  # Recursively delete `.DS_Store` files
  alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

  # Pipe my public key to my clipboard.
  alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

  # Short-cuts for copy-paste.
  alias c='pbcopy'
  alias p='pbpaste'

  # Remove all items safely, to Trash (`brew install trash`).
  alias rm='trash'

  # Case-insensitive pgrep that outputs full path.
  alias pgrep='pgrep -fli'

  # Empty the Trash on all mounted volumes and the main HDD
  # Also, clear Apple’s System Logs to improve shell startup speed
  alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

  # delete dsstore files
  alias dsstore="find . -name '*.DS_Store' -type f -ls -delete"

  # Open iOS Simulator app
  alias ios="open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app"
fi

# Git aliases
# You must install Git first
# alias g="git"
# alias gundo='git reset --hard HEAD~1' Ref: http://stackoverflow.com/a/6376039/2968891
# alias grvrt='git revert HEAD'
# alias gco='git checkout'
# alias grm='git remote'
# alias ga='git add'
# alias gc='git commit'
# alias gb='git branch'
# alias gcl='git clone'
# alias gcln='git clean'
# alias gd='git diff'
# alias gi='subl .gitignore'
# alias gl='git log'
# alias grm='git remove'
# alias gs='git status'
# alias gsm='git submodule'
# alias gpush='git push'
# alias gl='git pull'
# alias gm='git merge'
# alias grs='git reset'
# alias gsh='git show'
# alias glogg="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
# alias glog='git log'
