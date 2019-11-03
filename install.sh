#!/bin/bash

cp ./vimrc ~/.vimrc

if [ ! -d ~/.dotfiles ]
then
    mkdir ~/.dotfiles
fi
cp -r ./shell ./tbw.sh ~/.dotfiles

cat ./bashrc > ~/.bashrc
