#! /bin/bash

# Check OS
os=0

if [ "$(uname)" == "Darwin" ]; then
    os='macos'
elif [ "$(pwd)" == "/workspaces/.codespaces/.persistedshare/dotfiles" ]; then
    os="gh"
elif [ "$(lsb_release -si)" == "Ubuntu" ]; then
    os='ubuntu'
else
    echo 'The script supports MacOs and Ubuntu only!';
    exit 1;
fi

logsDate="$(date +%F_%H-%M-%S)"

# Parse flags

dryRun=0;
isInteractive=0;

flags=$(getopt -l "dry" -- "$@")
set -- $flags

while [ $# -gt 0 ]
do
    case $1 in
        --dry-run)
            echo -e "Running in dry-run mode. No files will be modified\n";
            dryRun=1;;
        --interactive)
            echo -e "Running in interactive mode! :)\n";
            isInteractive=1;;
    esac
    # Fetch next argument as 1st
    shift
done

# Arg 1: Name, Arg 2: Name in package manager
function install_app() {
    echo -e "\nInstalling $1..."

    if [ "$os" == "macos" ]; then
        brew_install $1 $2  >> "$HOME/.ammardev_dotfiles_installation_$logsDate.log"
    else
        apt_install $1 $2  >> "$HOME/.ammardev_dotfiles_installation_$logsDate.log"
    fi
}

function brew_install() {
    if ! command -v brew &> /dev/null; then
        echo -e "\nHomebrew is not found please install it and try again (https://brew.sh)"
        exit 1
    fi

    brew install "$2"
}

function apt_install() {
    if ! command -v apt-get &> /dev/null; then
        echo -e "\nApt is not found!!"
        exit 1
    fi

    if [ "$os" == "gh" ]; then
        sudo apt-get install "$2" -y 
    else
        apt-get install "$2" -y
    fi
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
    if [ "$os" == "macos" ]; then
        install_app "NeoVim" "nvim"
    else
        curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
        chmod u+x nvim.appimage
        ./nvim.appimage --appimage-extract
        sudo mv squashfs-root /
        sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
    fi

    install_app "ripgrep" "ripgrep"
    install_app "gcc" "gcc"
    install_app "npm" "npm"
    install_app "golang" "golang"
    install_app "Python VEnv" "python3-venv"

    backup_existed_dotfile "NeoVim" ".config/nvim"

    install_new_dotfiles "NeoVim" "nvim" ".config/nvim"
}

function tmux_install() {
    install_app "Tmux" "tmux"

    backup_existed_dotfile "Tmux" ".tmux.conf"

    install_new_dotfiles "Tmux" "tmux/tmux.conf" ".tmux.conf"
}

function zsh_install() {
    install_app "Zsh" "zsh"

    backup_existed_dotfile "ZSH" ".zsh"
    backup_existed_dotfile "ZSH" ".zshrc"

    install_new_dotfiles "zsh directory" "zsh" ".zsh"
    install_new_dotfiles "zshrc file" "zshrc" ".zshrc"

    sudo chsh -s "$(which zsh)"
}

function install_all() {
    echo -e "\nInstalling all dotfiles";

    nvim_install;
    tmux_install;
    zsh_install;
}

PS3="Select dotfiles to install: "

if (($isInteractive)); then
    select selected in "All dotfiles" "NeoVim" "Tmux" "ZSH"; do
        case $selected in
            "All dotfiles")
                install_all;;
            "NeoVim")
                nvim_install;;
            "Tmux")
                tmux_install;;
            "ZSH")
                zsh_install;;
            *)
                echo "Invalid Command";
                exit 1;;
        esac
        break;
    done
else
    if [ "$os" == "gh" ] || [ "$os" == "ubuntu" ]; then
        sudo apt-get update -y >> "$HOME/.ammardev_dotfiles_installation_$logsDate.log"
    fi

    if [ ! -d "$HOME/.config" ]; then
        mkdir "$HOME/.config"
    fi

    install_all;
fi
