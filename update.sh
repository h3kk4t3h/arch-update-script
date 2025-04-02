#!/bin/bash

# Exit if a command fails
set -e

# Make sure script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi


# Update pacman
echo "Updating pacman packages..."
sudo pacman -Syu --noconfirm

# Update yay
echo "Updating yay..."
if command -v yay > /dev/null; then
    sudo -u $SUDO_USER yay --noconfirm
else
    echo "yay is not installed. Skipping AUR updates."
fi

# Update pip 
echo "Updating pip"
if command -v pipx > /dev/null; then
    sudo -u $SUDO_USER pipx install --force pip
    sudo -u $SUDO_USER pipx ensurepath
else
    echo "pipx is not installed. Skipping pip update."
fi

# Update Flatpak packages
echo "Updating Flatpak"
if command -v flatpak > /dev/null; then
    /usr/bin/flatpak update -y || true
else
    echo "Flatpak is not installed. Skipping Flatpak updates."
fi

# Update npm
echo "Updating npm"
if command -v npm > /dev/null; then
    npm update -g --unsafe-perm
else
    echo "npm is not installed. Skipping npm updates."
fi


wait

# Update HyDE 
echo "Updating HyDE repo"
if [ -d "$HOME/HyDE" ]; then
    git -C "$HOME/HyDE" pull
else
    git clone --depth 1 https://github.com/HyDE-Project/HyDE ~/HyDE
fi

# Run HyDE install script with -restore
if [ -f "$HOME/HyDE/Scripts/install.sh" ]; then
    echo "Updating HyDE"
    /bin/bash "$HOME/HyDE/Scripts/install.sh" -r
else
    echo "HyDE installation script not found! Skipping..."
fi

echo "All updates completed successfully!"