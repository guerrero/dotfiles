function edit_dotfiles --description "Edit dotfiles using default editor"
  set dotfiles_dir (dirname (dirname (dirname (readlink (dirname (dirname (status -f)))))))

  $EDITOR $dotfiles_dir
end
