#!/bin/sh

echo "auto configure script!"

distro=`lsb_release -is | awk '{print tolower($0)}'`
# distro=$1

install_cmd=""
case $distro in
        "ubuntu" | "debian")
                install_cmd="sudo apt-get install"
                ;;
        "manjaro" | "archlinux")
                install_cmd="sudo pacman -S"
                ;;
        *)
                echo "$distro not support!"
                exit 1
                ;;
esac
echo "OS distro: $distro"

echo "installing base package....."
$install_cmd zsh git python python3 python-pip python3-pip

echo "configuring zsh....."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

[ -d $HOME/bin/ ] || mkdir $HOME/bin

echo "installing nvim...."
curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -o $HOME/bin/nvim
chmod +x $HOME/bin/nvim

pip2 install --user --upgrade pynvim
pip3 install --user --upgrade pynvim

nvim_config_dir=$HOME/.config/nvim/
[ -d $nvim_config_dir ] || mkdir -p $nvim_config_dir
git clone https://github.com/latiaoxia/nvim.config.git $nvim_config_dir


