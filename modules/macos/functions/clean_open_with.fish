function clean_open_with_duplicates --description "Remove duplicates in the “Open With” menu"
  /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
end
