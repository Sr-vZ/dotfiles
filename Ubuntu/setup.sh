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
    build-essential
    fontconfig
    git
    ripgrep
    fzf
    zsh
    bat
    neovim
    tmux
    bpytop
    python3
    golang-go
    # rustc
    # cargo
    docker.io
)

for package in "${packages_to_install[@]}"; do
    sudo apt install -y "$package" &
done

# Install zellij (tmux alternative)
# cargo install zellij exa

# Add user to the docker group
sudo usermod -aG docker $USER
# use zsh as default
# sudo chsh —s $(which zsh) $USER
if command -v curl >/dev/null 2>&1; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
else
  sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
fi

echo "System update and upgrade, installation, and configuration completed!"
