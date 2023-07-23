# Avoid config if requirements are not found.
if not test (uname) = 'Darwin'
  exit
end

# Short-cuts for copy-paste.
alias c 'pbcopy'
alias p 'pbpaste'

# Lock the screen (when going AFK)
alias afk "/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Start ScreenSaver. This will lock the screen if locking is enabled.
alias ss "open /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app"
  
# Merge PDF files
# Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
alias mergepdf '/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'

