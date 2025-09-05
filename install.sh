#!/bin/bash
set -e

echo "Installer..."

install_brew() {
    echo "Preparing to download brew"
    if which brew >/dev/null; then
        echo "warning: brew is already installed, skipping installation."
    else
        echo "Running brew installer"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile;
        eval "$(/opt/homebrew/bin/brew shellenv)";
    fi
    
    cd brew/;
    echo "Move to brew directiory: $(pwd)";
    brew bundle;
    cd -
}

installer_oh_my_zsh() {
    echo "Installing oh-my-zsh from https://ohmyz.sh/#install";
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

installer_others() {
    echo "Download Sublime from https://www.sublimetext.com/download\nVersion not available on Brew, yet."
    echo "how to install all plugins on Sublime Text, VS Code "
    echo "Download and install Hack font: https://github.com/source-foundry/Hack"
    echo "Download Logitech Options - https://www.logitech.com/en-us/product/options"
    
}

installer_oh_my_zsh
install_brew
installer_others
