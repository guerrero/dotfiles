set -l current_dir (realpath (dirname (status -f)))
set -l parent_dir (dirname $current_dir)

source "$parent_dir/lib/messages.fish"

function parse_config_file $argv
  set homebrew_dir (realpath (dirname (status -f)))

  set file_content (cat -e $homebrew_dir/settings/$argv)
  set splitted_content (string split '$' $file_content)

  for line in $splitted_content
    set line_without_comments (string replace -a -r '#.*$' '' $line)
    set trimmed_line (string trim $line_without_comments)
    if test -n $trimmed_line
      echo $trimmed_line
    end
  end
end

function install_repositories
  set repositories_to_install (parse_config_file repositories)
  set installed_repositories (brew tap)

  for repository in $repositories_to_install
    set repository_name (echo (string split -r -m1 '/' $repository)[2])

    if contains $repository $installed_repositories
      print_warning "Repository $repository_name has been added previously."
    else
      print_message "Adding $repository_name repository to Homebrew..."
        and brew tap $repository
        and print_done
    end
  end
end

function install_binaries
  set binaries_to_install (parse_config_file binaries)
  set installed_binaries (brew list)

  for binary in $binaries_to_install
    set formula_wo_options (string replace -r " .*" "" $binary)
    set formula_name (string replace -r ".*/" "" $formula_wo_options)

    if contains $formula_name $installed_binaries
      print_warning "A formula for $formula_name is already installed."
    else
      print_message "Installing binary for $formula_name..."
        and brew install (string split " " $binary)
        and print_done
    end
  end
end

function install_casks
  set casks_to_install (parse_config_file casks)
  set installed_casks (brew cask list)

  for cask in $casks_to_install
    if contains $cask $installed_casks
      print_warning "A cask for $cask is already installed."
    else
      print_message "Installing $cask cask..."
        and brew cask install $cask
        and print_done
    end
  end
end

# Update Homebrew to ensure we are using the latest Homebrew-cask version
brew update

install_repositories
install_binaries
install_casks

# Remove outdated versions from the cellar
brew cleanup
brew cask cleanup
