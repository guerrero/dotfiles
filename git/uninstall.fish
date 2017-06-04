set -l current_dir (realpath (dirname (status -f)))
set -l parent_dir (dirname $current_dir)

source "$parent_dir/lib/messages.fish"
source "$parent_dir/lib/file.fish"

function uninstall_git
  type -q git
    and print_message "Uninstalling binary for git..."
    and brew uninstall git
end

function unlink_gitconfig
  set -l current_dir (realpath (dirname (status -f)))
  set -l gitconfig_source_path "$current_dir/settings/gitconfig"
  set -l gitconfig_dest_path "$HOME/.gitconfig"

  test -e gitconfig_dest_path
    and test (readlink gitconfig_dest_path) = gitconfig_source_path
    and print_message "Removing gitconfig symlink..."
    and rm gitconfig_dest_path
    and print_done
end

uninstall_git
  and unlink_gitconfig
