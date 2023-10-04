# dotfiles
My personal dotfiles with installation script

The installation script will do the following:
* Install the app from Homebrew (If it's not installed).
* Backup your existing dotfiles.
* Add the new dotfiles using symbolic link (To be able to update the dotfiles form the repo later).

## Installation
Run the installation command:
```bash
chmod +x install.sh
./install.sh
```

You can run the command using dry run mode to test the command without modifing your files.
```bash
./install.sh --dry-run
```

The script will ask you which dotfile you want to install:
<img width="512" alt="image" src="https://github.com/ammardev/dotfiles/assets/16087389/c0100f36-3ab9-4d09-b655-64001905f8dc">

## Docs
* [Custom Remaps](docs/remaps.md)

## TODO
* Installation Script
  * Support Ubuntu
  * Add ITerm2 Profile
* Dotfiles
  * Add default LSPs
