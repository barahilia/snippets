#!/bin/sh

repo_dir=$(readlink -f $(dirname $0))
conf_dir=${repo_dir}/conf

rmdir \
    ~/Desktop ~/Public ~/Templates ~/Documents \
    ~/Music ~/Pictures ~/Videos ~/Downloads

mkdir -p \
    ~/bin ~/proj ~/repos ~/tmp \
    ~/data ~/data/desktop \
    ~/.local ~/.local/bin ~/.local/share/nvim/site/autoload \
    ~/.config ~/.config/git ~/.config/nvim

# Consider running apt update before
sudo apt install -y \
    tmux git neovim curl xclip \
    python3-pip openjdk-11-jre \
    freeplane \
    fasd jq meld fzf ripgrep

# Eliminate DEP-11 in apt update
sudo apt purge -y appstream

bat_ver=0.20.0
bat_deb=bat_${bat_ver}_amd64.deb
curl -L -O https://github.com/sharkdp/bat/releases/download/v$bat_ver/$bat_deb
sudo dpkg -i $bat_deb
rm $bat_deb

mkdir -p ~/bin/fzf-etc
curl -o ~/bin/fzf-etc/completion.bash \
    https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.bash
curl -o ~/bin/fzf-etc/key-bindings.bash \
    https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.bash

ln -sf ${conf_dir}/vimrc ~/.config/nvim/init.vim
ln -sf ${conf_dir}/personal.vim ~/.local/share/nvim/site/autoload/personal.vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -s /usr/bin/python3 ~/bin/python
ln -s /usr/bin/fasd ~/bin/fasd

ln -sf ${conf_dir}/profile ~/.profile
ln -sf ${conf_dir}/bashrc ~/.bashrc
ln -sf ${conf_dir}/aliases ~/.aliases
ln -sf ${conf_dir}/inputrc ~/.inputrc

ln -sf ${conf_dir}/tmux.conf ~/.tmux.conf
ln -sf ${conf_dir}/user-dirs.dirs ~/.config/user-dirs.dirs
ln -sf ${conf_dir}/ripgreprc ~/.config/ripgreprc

cat ${conf_dir}/gitconfig.base | \
    sed "s.<CONF_DIR>.${conf_dir}." > ~/.config/git/config

python3 -m pip install --upgrade pip
pip install -r ${repo_dir}/python.reqs

ln -s /home/iliab/.local/bin/bpytop top
