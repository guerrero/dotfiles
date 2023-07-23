# Init fish modules

eval (/opt/homebrew/bin/brew shellenv)

set -l fish_settings_dir (readlink (dirname (status -f)))
set -l modules_dir (dirname (dirname $fish_settings_dir))

mkdir -p $fish_settings_dir/functions

for path in $modules_dir/*
  if test -e $path/init.fish
    source $path/init.fish
  end

  for module_function in $path/functions/*.fish
    set -l function_dirname (dirname $module_function)

    if test $function_dirname != $fish_settings_dir"functions"
      set -l function_name (string split -r -m1 / $module_function)[2]
      set -l symlink_path $fish_settings_dir/functions/$function_name
      set -l symlink_reference (readlink $symlink_path)

      if test -e $symlink_path
        if test $symlink_reference != $module_function
          set_color yellow; echo -n "Warning: "; set_color normal
          echo "Duplicated fish function for $function_name."
        end
      else
        ln -s $module_function $symlink_path
      end
    end
  end
end