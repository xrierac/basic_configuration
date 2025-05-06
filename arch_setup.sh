#!/bin/bash

# Update the system
sudo pacman -Syu --noconfirm

# Install vim
echo "Installing vim"
sudo pacman -S --noconfirm vim

# Install zsh and make it the default shell
#echo "Installing zsh and making it the default shell..."
#sudo pacman -S --noconfirm zsh zsh-completions
#zsh
#chsh -s /usr/bin/zsh

# Install and activate OpenSSH
echo "Installing OpenSSH..."
sudo pacman -S --noconfirm openssh

# Improve security
echo "Disabling login as root and password authentication..."
sudo mkdir -p /etc/ssh/sshd_config.d/
echo "PermitRootLogin no" | sudo tee /etc/ssh/sshd_config.d/20-deny_root.conf
echo "PasswordAuthentication no" | sudo tee -a /etc/ssh/sshd_config.d/20-force_publickey_auth.conf
echo "AuthenticationMethods publickey" | sudo tee -a /etc/ssh/sshd_config.d/20-force_publickey_auth.conf
echo "Enabling and starting sshd service..."
sudo systemctl enable sshd.service
sudo systemctl start sshd.service

echo "OpenSSH installed and sshd service activated."

# Install Firefox and extensions
echo "Installing Firefox and extensions..."
sudo pacman -S --noconfirm firefox firefox-ublock-origin firefox-decentraleyes

# Install Docker
echo "Installing Docker..."
sudo pacman -S --noconfirm docker

# Enable and start Docker service
echo "Enabling and starting Docker service..."
sudo systemctl enable docker.service
sudo systemctl start docker.service

# Add the current user to the docker group
echo "Adding user to docker group..."
sudo usermod -aG docker $USER

# Install Docker Compose
echo "Installing Docker Compose..."
sudo pacman -S --noconfirm docker-compose

# Prompt for optional installation of Hyprland, UWSM, Kitty, and Waybar
read -p "Do you want to install Hyprland? (y/N): " install_choice

if [[ "$install_choice" =~ ^[Yy]$ ]]; then
    echo "Installing Hyprland and required tools..."
    sudo pacman -S --noconfirm hyprland hyprsunset uwsm kitty waybar \
        hyprpolkitagent wofi libnewt otf-font-awesome
    mkdir -p /home/$USER/.config/waybar
    cp /etc/xdg/waybar/* /home/$USER/.config/waybar/
    systemctl --user enable --now waybar.service
    cat << 'EOF' >> ~/.bash_profile
if uwsm check may-start; then
    exec uwsm start hyprland.desktop
fi
EOF
else
    echo "Skipping installation of Hyprland, UWSM, Kitty, and Waybar."
fi

# Verify installation
echo "Verifying Docker, Docker Compose, and Firefox installation..."
docker --version
docker-compose --version
firefox --version

echo "Installation complete. Please log out and log back in for the group changes to take effect."
