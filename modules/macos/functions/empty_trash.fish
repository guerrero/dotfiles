function empty_trash --description 'Empty the Trash on all mounted volumes and the main disk'
  sudo rm -rfv /Volumes/*/.Trashes
  sudo rm -rfv ~/.Trash
  sudo rm -rfv /private/var/log/asl/*.asl
end