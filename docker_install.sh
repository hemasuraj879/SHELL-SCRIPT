#!/bin/bash

# Update the package database
sudo dnf update -y

# Remove any older versions of Docker if they exist
sudo dnf remove -y docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-engine

# Install required packages
sudo dnf install -y dnf-plugins-core

# Set up the Docker repository
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker Engine
sudo dnf install -y docker-ce docker-ce-cli containerd.io

# Start Docker
sudo systemctl start docker

# Enable Docker to start on boot
sudo systemctl enable docker

# Add current user to the docker group
sudo groupadd docker
sudo usermod -aG docker $USER

#Download Docker Compose:
sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

#Apply Executable Permissions
sudo chmod +x /usr/local/bin/docker-compose

# Inform the user to log out and log back in
echo "You need to log out and log back in for the group changes to take effect."


