#!/bin/sh

sudo apt install \
    tmux git vim \
    openjdk-11-jre-headless

rmdir \
    ~/Desktop ~/Templates ~/Documents \
    ~/Music ~/Pictures ~/Videos

mkdir \
    ~/bin ~/data ~/proj ~/repos ~/tmp \
    ~/.local ~/.local/bin
