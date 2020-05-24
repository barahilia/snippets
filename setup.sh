#!/bin/sh

sudo apt install -y \
    tmux git vim \
    python3-pip \
    openjdk-11-jre-headless

rmdir \
    ~/Desktop ~/Public ~/Templates ~/Documents \
    ~/Music ~/Pictures ~/Videos ~/Downloads

mkdir -p \
    ~/bin ~/proj ~/repos ~/tmp \
    ~/data ~/data/desktop \
    ~/.local ~/.local/bin

ln -s /usr/bin/python3 ~/bin/python
