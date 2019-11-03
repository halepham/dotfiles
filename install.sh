#!/bin/bash

# Backup files before install
if [ ! -d ./bkp ]
then
    mkdir bkp
fi

if [ -f ~/.vimrc ]
then
    cp ~/.vimrc "./bkp/vimrc_$(date '+%Y%m%d%H%M%S')"
    cp ~/.bashrc "./bkp/bashrc_$(date '+%Y%m%d%H%M%S')"
fi

cp ./vimrc ~/.vimrc

if [ ! -d ~/.dotfiles ]
then
    mkdir ~/.dotfiles
fi
cp -r ./shell ./tbw.sh ~/.dotfiles

cat ./bashrc >> ~/.bashrc
