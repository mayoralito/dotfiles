
# Check if brew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Please install Homebrew first."
    exit 1
fi  

# Credits:
# https://gist.github.com/davidteren/898f2dcccd42d9f8680ec69a3a5d350e Nerd Fonts and
# https://github.com/source-foundry/Hack 

install_hack_font() {
    if ls ~/Library/Fonts/Hack-*.ttf &>/dev/null; then
        echo "Hack font is already installed."
    else
        echo "Downloading Hack font from Source Foundry releases..."
        curl -L -o /tmp/Hack-v3.003-ttf.zip https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
        unzip -o /tmp/Hack-v3.003-ttf.zip -d /tmp/Hack-fonts
        mkdir -p ~/Library/Fonts

        cp -frv /tmp/Hack-fonts/ttf/*.ttf ~/Library/Fonts/

        echo "Cleaning up temporary files..."
        # rm -rf /tmp/Hack-v3.003-ttf.zip /tmp/Hack-fonts
        
        echo "Hack font downloaded and installed to ~/Library/Fonts."
    fi
}

# Function to install all available Nerd Fonts
install_all_nerd_fonts() {
    # Get list of all nerd font casks
    font_casks=$(brew search '/font-.*-nerd-font/' | awk '{ print $1 }')

    # Check each font and install only if not already installed
    for font_cask in $font_casks; do
        if brew list --cask "$font_cask" &>/dev/null; then
            echo "$font_cask is already installed."
        else
            echo "Installing $font_cask..."
            brew install --cask "$font_cask" || true
        fi
    done
}

if [[ "$1" == "--install-hack" ]]; then
    echo "Installing Hack Nerd fonts..."
    install_all_nerd_fonts
else
    echo "Installing Hack font..."
    install_hack_font
fi

# #!/bin/bash

# fonts_list=(
#   font-3270-nerd-font
#   font-fira-mono-nerd-font
#   font-inconsolata-go-nerd-font
#   font-inconsolata-lgc-nerd-font
#   font-inconsolata-nerd-font
#   font-monofur-nerd-font
#   font-overpass-nerd-font
#   font-ubuntu-mono-nerd-font
#   font-agave-nerd-font
#   font-arimo-nerd-font
#   font-anonymice-nerd-font
#   font-aurulent-sans-mono-nerd-font
#   font-bigblue-terminal-nerd-font
#   font-bitstream-vera-sans-mono-nerd-font
#   font-blex-mono-nerd-font
#   font-caskaydia-cove-nerd-font
#   font-code-new-roman-nerd-font
#   font-cousine-nerd-font
#   font-daddy-time-mono-nerd-font
#   font-dejavu-sans-mono-nerd-font
#   font-droid-sans-mono-nerd-font
#   font-fantasque-sans-mono-nerd-font
#   font-fira-code-nerd-font
#   font-go-mono-nerd-font
#   font-gohufont-nerd-font
#   font-hack-nerd-font
#   font-hasklug-nerd-font
#   font-heavy-data-nerd-font
#   font-hurmit-nerd-font
#   font-im-writing-nerd-font
#   font-iosevka-nerd-font
#   font-jetbrains-mono-nerd-font
#   font-lekton-nerd-font
#   font-liberation-nerd-font
#   font-meslo-lg-nerd-font
#   font-monoid-nerd-font
#   font-mononoki-nerd-font
#   font-mplus-nerd-font
#   font-noto-nerd-font
#   font-open-dyslexic-nerd-font
#   font-profont-nerd-font
#   font-proggy-clean-tt-nerd-font
#   font-roboto-mono-nerd-font
#   font-sauce-code-pro-nerd-font
#   font-shure-tech-mono-nerd-font
#   font-space-mono-nerd-font
#   font-terminess-ttf-nerd-font
#   font-tinos-nerd-font
#   font-ubuntu-nerd-font
#   font-victor-mono-nerd-font
# )

# brew tap homebrew/cask-fonts

# for font in "${fonts_list[@]}"
# do
#   brew install --cask "$font"
# done
# exit