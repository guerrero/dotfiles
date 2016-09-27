set -l current_dir (dirname (status -f))

source "$current_dir/string.fish"
source "$current_dir/messages.fish"
source "$current_dir/file.fish"

function test_app_installed -a app_name
  set app_path "/Applications/$app_name.app"

  test -d $app_path; and test -s $app_path
    and return 0
    or return 1
end

function install_app -a app_name
  set app_cask (kebab_case $app_name)

  test_app_installed $app_name
    and print_message "$app_name is already installed"
    and return 0

  not type -q brew
    and print_error "Required dependency brew is not installed. Aborting $app_name setup"
    and return 1

  if not brew cask > /dev/null
    print_message -n "Adding Homebrew-Cask to Homebrew's repos list..."
      and brew tap caskroom/cask > /dev/null
      and print_done
    or print_error \n"Error trying to tap Homebrew-Cask"
      and return 1
  end

  print_message -n "Installing $app_name..."
    and brew cask install $app_cask > /dev/null
    and print_done
    and return 0
  or print_error \n"Error trying to install $app_name"
    and return 1

  set -e app_cask
end

function uninstall_app
  set app_name $argv[1]
  set -e argv[1]
  set app_files $argv

  if not test_app_installed $app_name
    print_message "$app_name is not installed or its path is different from /Applications/$app_name.app"
  else
    set app_cask (kebab_case $app_name);

    if type -q brew; and brew cask > /dev/null; and brew cask list | grep $app_cask > /dev/null
        sudo -v
          and print_message -n "Uninstalling $app_name cask..."
          and brew cask zap $app_cask > /dev/null
        or brew cask uninstall $app_cask > /dev/null
          and print_done
        or print_error \n"Error trying to remove $app_name cask"
          and return 1
    else
      set app_path "/Applications/$app_name.app"

      print_message -n "Removing $app_name app..."
        and rm -rf $app_path
        and print_done
      or print_error \n"Error trying to remove $app_name"
        and return 1
    end
  end

  if count $app_files > /dev/null
    remove_files $app_files
      and return 0
    or print_error "Error trying to remove $app_name's extra files"
      and return 1
  end
end
