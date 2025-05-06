#!/bin/bash

# Update the system
sudo pacman -Syu --noconfirm

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

# Verify installation
echo "Verifying Docker, Docker Compose, and Firefox installation..."
docker --version
docker-compose --version
firefox --version

echo "Installation complete. Please log out and log back in for the group changes to take effect."
