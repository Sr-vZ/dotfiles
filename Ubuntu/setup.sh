#!/bin/bash
cat << EOF
███████╗██████╗ ██╗   ██╗███████╗
██╔════╝██╔══██╗██║   ██║╚══███╔╝
███████╗██████╔╝██║   ██║  ███╔╝ 
╚════██║██╔══██╗╚██╗ ██╔╝ ███╔╝  
███████║██║  ██║ ╚████╔╝ ███████╗
╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝
EOF
echo "Ubuntu Setup Script"

# Update package lists
sudo apt update

# Upgrade installed packages
sudo apt upgrade -y

# Install the specified packages with loading animation
packages_to_install=(
    libssl-dev
    pkg-config
    neovim
    tmux
    bpytop
    python3
    golang-go
    rustc
    cargo
    docker.io
)

for package in "${packages_to_install[@]}"; do
    sudo apt install -y "$package" &
    spinner $!
done

# Install zellij (tmux alternative)
cargo install zellij

# Add user to the docker group
sudo usermod -aG docker $USER

echo "System update and upgrade, installation, and configuration completed!"
