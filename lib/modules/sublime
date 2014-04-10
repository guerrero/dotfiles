#!/bin/env bash

# TODO: I need this???
DOTFILES="$HOME/Dev/dotfiles"

# TODO: Check where sublime projects are stored to know if i need to include it in dotfiles

sublime() {
	case "$1" in
		setup)
			sublime_setup
		;;

		pkgcontrol)
			sublime_package_control
		;;

		import)
			import_sublime_settings
		;;

		link)
			link_sublime_settings
		;;
	esac
}

sublime_setup() {
	set_sublime_path
	if [ -e "$sublime_app_dir" ]; then
		dot_close_app

		# Create Sublime settings folders if they don't exist
		mkdir -p "$sublime_settings_dir"/{Packages,Installed\ Packages}

		link_sublime_settings

		sublime_package_control

	else
		echo "Sublime Text isn't installed or settings folder doesn't exist"
	fi

}

# Check where Sublime settings have been installed
set_sublime_path() {
	if [ `uname -s` = "Darwin" ]; then
		sublime_app_dir=/Applications/Sublime\ Text.app
		sublime_settings_dir=~/Library/Application\ Support/Sublime\ Text\ 3

	elif [ `uname -s` = "Linux" ]; then
		sublime_app_dir=/usr/lib/sublime-text-3
		sublime_settings_dir=~/.config/sublime-text-3/
	else
		echo "ERROR: Unknown operating system"; exit
	fi
}

link_sublime_settings() {
	#Create symlinks to dotfiles and backup the previous packages with the same name if exists
	if [ -d "$DOTFILES" ]; then
		for package in $DOTFILES/sublime/*-package; do
			echo "Creating symbolic link for $(basename "$package")..."
			if [ ! "`readlink \"$sublime_settings_dir/Packages/$(basename "$package" -package)\"`" = "$package" ]; then

				if [ "$package" = "$DOTFILES/sublime/User-package" ]; then
					echo "Removing Package Control caches..."
					find "$package" -maxdepth 1 -name "Package Control*" -not -name "Package Control.sublime-settings" -exec rm -rf {} \;
				fi

				# TODO: Choose behaviour to rm or mv packages .backup
				rm -rf "$sublime_settings_dir/Packages/$(basename "$package" -package)".backup
				mv "$sublime_settings_dir/Packages/$(basename "$package" -package)"{,.backup}
				ln -s "$package" "$sublime_settings_dir/Packages/$(basename "$package" -package)"

			else
				echo "$(basename "$package") is already linked into Sublime folder"
			fi
		done
	else
		echo "Ups, dotfiles folder doesn't exists or '$DOTFILES' global is set to an unknown path"
	fi
}


sublime_install_package_control() {
	if [ ! -f "$sublime_settings_dir/Installed Packages/Package Control.sublime-package" ]; then
		curl -ssl https://sublime.wbond.net/Package%20Control.sublime-package > "$sublime_settings_dir/Installed Packages/Package Control.sublime-package"

		[ -e "$DOTFILES/sublime/User-package/Package Control.sublime-settings" ] \
		&& echo "Please after open Sublime Text don't close it unless packages installation is complete"
	else
		echo "Package Control already exists"
	fi
}

import_sublime_settings() {
 link_sublime_settings
}