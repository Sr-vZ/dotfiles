#!/bin/bash
cat << EOF
███████╗██████╗ ██╗   ██╗███████╗
██╔════╝██╔══██╗██║   ██║╚══███╔╝
███████╗██████╔╝██║   ██║  ███╔╝ 
╚════██║██╔══██╗╚██╗ ██╔╝ ███╔╝  
███████║██║  ██║ ╚████╔╝ ███████╗
╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝
EOF
# Function to detect the distro
detect_distro() {
  if [[ -f /etc/debian_version ]]; then
    distro="debian"
  elif [[ -f /etc/ubuntu ]]; then
    distro="ubuntu"
  elif [[ -f /etc/arch-release ]]; then
    distro="arch"
  else
    echo "Unsupported distro"
    exit 1
  fi
}

# Function to install packages based on distro
install_packages() {
  case "$distro" in
    debian|ubuntu)
      sudo apt update && sudo apt install -y "${packages[@]}" ;;
    arch)
      sudo pacman -Syu && sudo pacman -S "${packages[@]}" ;;
    *)
      echo "Unsupported distro"
      exit 1 ;;
  esac
}

# List of packages to install
packages=(
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
)

# Detect distro
detect_distro

# Install packages
install_packages

if [[ $(which docker) && $(docker --version) ]]; then
    echo "Docker already installed"
    # command
  else
    echo "Install docker"
    # command
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo groupadd docker
    # Add user to the docker group
    sudo usermod -aG docker $USER
fi

if [[ $(which nvim) && $(nvim --version) ]]; then
    echo "Neovim already installed"
else
    echo "Building Neovim"
    
    # Neovim latest stable version installation
    git clone https://github.com/neovim/neovim.git
    cd neovim
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
fi

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
curl https://raw.githubusercontent.com/Sr-vZ/dotfiles/main/tmux/tmux.conf -o ~/.tmux.conf

git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
