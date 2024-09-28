#!/bin/bash

# Update the package index
echo "Updating package index..."
sudo apt update -y

# Install necessary packages for Docker
echo "Installing required packages..."
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker’s official GPG key
echo "Adding Docker’s official GPG key..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the stable repository
echo "Setting up Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package index again
echo "Updating package index again..."
sudo apt update -y

# Install Docker Engine, CLI, and containerd
echo "Installing Docker Engine..."
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start and enable Docker service
echo "Starting and enabling Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

# Verify the installation
echo "Verifying Docker installation..."
sudo docker --version

# Add the current user to the docker group to avoid using sudo with Docker
echo "Adding the current user to the docker group..."
sudo usermod -aG docker $USER

echo "Docker installation completed. Please log out and log back in to apply the user group changes."
