function create_bootable_usb --description 'Create a bootable USB from an ISO image' --argument-names os_image_file usb_path usb_device_node
  echo $os_image_file
  echo $usb_path

  set os_image_no_ext (string replace -r ".iso" "" "$os_image_file")

  hdiutil convert -format UDRW -o $os_image_no_ext "$os_image_no_ext.img"
  diskutil list
  diskutil unmountDisk /dev/$usb_device_node
  sudo dd if="$os_image_no_ext.img" of=/dev/$usb_device_node bs=1m
  diskutil eject /dev/$usb_device_node
end