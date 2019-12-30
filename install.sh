#!/bin/bash

# Create dir
mkdir -p $HOME/.dotfiles/bkp/
mkdir -p $HOME/.dotfiles/shell/

SCRIPT_PATH=$(dirname $0)
DOTFILE=$HOME/.dotfiles
BKP=$DOTFILE/bkp
SHELL=$DOTFILE/shell

# Backup files before update.
[ -f $HOME/.vimrc ] && cp ~/.vimrc "$BKP/vimrc_$(date '+%Y%m%d%H%M%S')"

[ -f $HOME/.config/nvim/init.vim ] && \
    cp $HOME/.config/nvim/init.vim "$BKP/init_vim_$(date '+%Y%m%d%H%M%S')"
[ -f $HOME/.config/nvim/coc-settings.json ] && \
    cp $HOME/.config/nvim/coc-settings.json "$BKP/coc-settings_$(date '+%Y%m%d%H%M%S')"

[ -f $HOME/.bashrc ] && cp $HOME/.bashrc "$BKP/bashrc_$(date '+%Y%m%d%H%M%S')"

[ -f $HOME/.inputrc ] && cp $HOME/.inputrc "$BKP/inputrc_$(date '+%Y%m%d%H%M%S')"

#Install
cp $SCRIPT_PATH/shell/* $SHELL
cp $SCRIPT_PATH/vimrc $HOME/.vimrc
cp $SCRIPT_PATH/inputrc $HOME/.inputrc

if [ ! "$( cat $HOME/.bashrc | grep \"\# My dotfiles\" )" ]
then
    cat $SCRIPT_PATH/bashrc >> $HOME/.bashrc
fi

if [ -f $HOME/.config/nvim/init.vim ]
then
    cp $SCRIPT_PATH/{vimrc, coc-settings.json} $HOME/.config/nvim
else
    mkdir -p $HOME/.config/nvim
    cp $SCRIPT_PATH/{vimrc, coc-settings.json} $HOME/.config/nvim
fi
