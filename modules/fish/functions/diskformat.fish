function diskformat --description "Format a disk with MS-DOS (FAT) format"
  set disk_number $argv[1]
  set disk_name $argv[2]

  diskutil eraseDisk FAT32 $disk_name /dev/disk$disk_number
end
