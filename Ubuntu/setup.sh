#!/bin/sh
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
sudo apt -o DPkg::Lock::Timeout=3 update

# Upgrade installed packages
sudo apt -o DPkg::Lock::Timeout=3 upgrade -y

# Install the specified packages with loading animation
packages_to_install=(
    "libssl-dev"
    "build-essential"
    "ninja-build"
    "gettext"
    "libtool"
    "libtool-bin"
    "autoconf"
    "automake"
    "cmake"
    "g++"
    "pkg-config"
    "unzip"
    "curl"
    "doxygen"
    "fontconfig"
    "git"
    "ripgrep"
    "fzf"
    "zsh"
    "bat"
    "tmux"
    "btop"
    "python3"
    "golang-go"
    # rustc
    # cargo
    # docker.io
    # podman
)

for package in "${packages_to_install[@]}"; do
    sudo apt -o DPkg::Lock::Timeout=3 install -y "$package" &
done

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo groupadd docker
# Add user to the docker group
sudo usermod -aG docker $USER
# Install zellij (tmux alternative)
# cargo install zellij exa

# use zsh as default
# sudo chsh —s $(which zsh) $USER


wget https://raw.githubusercontent.com/mcarvalho1/Nerd-fonts-Downloader-Script/master/nf_downloader.sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
curl https://raw.githubusercontent.com/Sr-vZ/dotfiles/main/tmux/tmux.conf -o ~/.tmux.conf



# wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz
# tar xzvf nvim-linux64.tar.gz
# alias nvim=./nvim-linux64/bin/nvim

# Neovim latest stable version installation
git clone https://github.com/neovim/neovim.git
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

# Lazyvim installation
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# curl -L https://raw.githubusercontent.com/Sr-vZ/dotfiles/main/Ubuntu/setup.sh | sh

# Install Lazydocker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# zsh4humans installtion
# if command -v curl >/dev/null 2>&1; then
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
# else
#   sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
# fi

# Zinit installtion
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"


echo "System update and upgrade, installation, and configuration completed!"
