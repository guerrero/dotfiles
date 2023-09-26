# Avoid config if requirements are not found.
if not test (uname) = 'Darwin'
  exit
end

# Short-cuts for copy-paste.
abbr -a c 'pbcopy'
abbr -a p 'pbpaste'

# Lock the screen (when going AFK)
abbr -a afk "/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Start ScreenSaver. This will lock the screen if locking is enabled.
abbr -a ss "open /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app"
  
# Merge PDF files
# Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
abbr -a mergepdf '/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'

