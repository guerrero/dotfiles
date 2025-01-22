# Dotfiles

> Highly opinionated configurations and scripts I use for my own machines.

## Requirements

- Mac OS 13 with Apple Silicon processor

## Installation

Clone the repo into your home folder and call it `~/.dotfiles`.

```shell
git clone https://github.com/guerrero/dotfiles "$HOME/.dotfiles"
```

Open a Terminal.app window and write the following command to set `~/.dotfiles` as the working directory.

```shell
cd "$HOME/.dotfiles"
```

Execute `setup` script to start the provision. To execute it, write the following command in the previously opened Terminal.app window.

```shell
./setup
```

This script will install all the apps and commands needed and set the configuration I use to work on my daily routine. Note that this process may take between 5-20 min to finish.

If you want to install any module individually or update it you can use the following command instead:

```shell
./setup_module "<module_dir_name>"
```

For example, if you want to setup the git module only you can do it using:

```shell
./setup_module "git"
```

## Uninstall

If you want to uninstall these dotfiles and revert all changes to the state prior to installation you can execute the `uninstall` command.

Open Terminal.app and write the following command to set `~/.dotfiles` as the working directory.

```shell
cd "$HOME/.dotfiles"
```

Execute `uninstall` script to revert all changes. To execute it, write the following command in the previously opened Terminal.app window.

```shell
./uninstall
```

This script will remove all previously installed apps and commands and undo the updates in configuration from the `setup` script. Note that this process may take between 5-20 min to finish.

If you want to uninstall any module individually or update it you can use the following command instead:

```shell
./setup_module "<module_dir_name>"
```

For example, if you want to uninstall the git module only you can do it using:

```shell
./setup_module "git"
```


## License

This project is licensed under The Unlicense license - see the [UNLICENSE](UNLICENSE) file for details.
