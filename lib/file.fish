set -l current_dir (dirname (status -f))

source "$current_dir/messages.fish"

function symlink -a source_path target_path
  test -L $target_path; and test (readlink $target_path) = $source_path
    and print_message "Settings for this app are already linked"
    and return 0

  if test -e $target_path
    print_message -n 'Replacing existing app settings by dotfiles settings...'
      and rm -rf $target_path
  else
    mkdir -p (dirname $target_path)
      and print_message -n 'Linking app settings...'
  end

  ln -s $source_path $target_path > /dev/null
    and print_done
end

function remove_files
  set files $argv

  for file in $files
    if test -e $file
      print_message -n "Removing $file..."
        and rm -rf $file > /dev/null
        and print_done
      or print_error \n "Error trying to remove $file"
        and return 1
    end

    return 0
  end

  return 0
end

function clean_file_functions
  functions -e \
    test_symbolic_link \
    symlink \
    remove_files \
    clean_file_functions
end
