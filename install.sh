#!/bin/bash
set -e

echo "Installer..."

install_brew() {
    echo "Preparing to download brew"
    if which brew >/dev/null; then
        echo "warning: brew is already installed, skipping installation."
    else
        echo "Running brew installer"
        # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    
    cd brew/;
    echo "Move to brew directiory: $(pwd)";
    brew bundle;
}

installer_two() {
    echo "Installer two..."
    cd brew;
    echo "done! $(pwd)"
}

install_brew
cd -
installer_two