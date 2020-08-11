#!/bin/sh

repo_dir=$(dirname $0)
conf_dir=${repo_dir}/conf

sudo apt install -y \
    tmux git vim curl \
    python3-pip \
    openjdk-11-jre-headless \
    fasd jq meld fzf ripgrep

bat_deb=bat_0.15.4_amd64.deb
curl -O https://github.com/sharkdp/bat/releases/download/v0.15.4/$bat_deb
sudo sudo dpkg -i $bat_deb
rm $bat_deb

rmdir \
    ~/Desktop ~/Public ~/Templates ~/Documents \
    ~/Music ~/Pictures ~/Videos ~/Downloads

mkdir -p \
    ~/bin ~/proj ~/repos ~/tmp \
    ~/data ~/data/desktop \
    ~/.local ~/.local/bin \
    ~/.config ~/.config/git

ln -s /usr/bin/python3 ~/bin/python
ln -s /usr/bin/fasd ~/bin/fasd

ln -s ~/.profile ${conf_dir}/profile
ln -s ~/.bashrc ${conf_dir}/bashrc
ln -s ~/.aliases ${conf_dir}/aliases

ln -s ~/.vimrc ${conf_dir}/vimrc
ln -s ~/.tmux.conf ${conf_dir}/tmux.conf
ln -s ~/.config/user-dirs.dirs ${conf_dir}/user-dirs.dirs

cat ${conf_dir}/gitconfig.base \
    sed "s.<CONF_DIR>.${conf_dir}." > ~/.config/git/config

python -m pip install --upgrade pip
pip install -r repo_dir/python.reqs
