#! /bin/bash

# Check OS
os=0

if [ "$(uname)" == "Darwin" ]; then
    os='macos'
elif [ "$(lsb_release -si)" == "Ubuntu" ]; then
    os='ubuntu'
else
    echo 'The script supports MacOs and Ubuntu only!';
    exit 1;
fi

# Parse flags

dryRun=0;

flags=$(getopt -l "dry" -- "$@")
set -- $flags

while [ $# -gt 0 ]
do
    case $1 in
        --dry-run)
            echo -e "Running in dry-run mode. No files will be modified\n"
            dryRun=1;;
    esac
    # Fetch next argument as 1st
    shift
done

# Arg 1: Name, Arg 2: Name in package manager
function install_app() {
    if ! command -v brew &> /dev/null; then
        echo -e "\nHomebrew is not found please install it and try again (https://brew.sh)"
        exit 1
    fi

    echo -e "\nInstalling $1..."

    brew install "$2"
}


# Arg 1: Name, Arg 2: Dotfile path
function backup_existed_dotfile() {
    if [ -f "$HOME/$2" ] || [ -d "$HOME/$2" ]; then
        echo -e "\nFound existing $1 configuration directory";
        backupDirectory="$HOME/$2-$(date +%F_%H-%M-%S)";

        if ((!$dryRun)); then
            mv "$HOME/$2" $backupDirectory;
        fi

        echo -e "\nBackup of the old version created at: $backupDirectory";
    fi
}

# Arg 1: Name, Arg 2: Source Path, Arg 3: destination path
function install_new_dotfiles() {
    if ((!$dryRun)); then
	ln -s "$(dirname "$(realpath "$0")")/$2" "$HOME/$3";
    fi

    echo -e "\n$1 Dotfiles installed";
}

function nvim_install() {
    install_app "NeoVim" "nvim"

    install_app "ripgrep" "ripgrep"

    backup_existed_dotfile "NeoVim" ".config/nvim"

    install_new_dotfiles "NeoVim" "nvim" ".config/nvim"
}

function tmux_install() {
    install_app "Tmux" "tmux"

    backup_existed_dotfile "Tmux" ".tmux"

    install_new_dotfiles "Tmux" "tmux" ".tmux"

    # Execute tpm install
}

PS3="Select dotfiles to install: "

select selected in "All dotfiles" "NeoVim" "Tmux"; do
    case $selected in
        "All dotfiles")
            echo -e "\nInstalling all dotfiles";

            nvim_install;
            tmux_install;;
        "NeoVim")
            nvim_install;;
        "Tmux")
            tmux_install;;
        *)
            echo "Invalid Command";
            exit 1;;
    esac
    break;
done

