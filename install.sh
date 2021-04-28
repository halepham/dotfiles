#!/bin/bash

SCRIPT_PATH=$(dirname $0)
BKP=$SCRIPT_PATH/backup
BASH_DIR=$HOME/.bash
TMUX_DIR=$HOME/.tmux
SCRIPT_DIR=$HOME/.script
NVIM_PATH=$(which nvim)
TMUX_VER=$(tmux -V | grep -oe"[0-9]*\.[0-9]*")

function backup() {
    echo Starting backup files at $(date)
    DATE=$(date '+%Y%m%d%H%M%S')

    # Create backup dir
    mkdir -p $SCRIPT_PATH/backup/

    [[ -f $HOME/.inputrc ]] && cp $HOME/.inputrc $BKP/inputrc_$DATE
    [[ -f $HOME/.lscolor ]] && cp $HOME/.lscolor $BKP/lscolor_$DATE
    [[ -f $HOME/.config/nvim/init.vim ]] && cp $HOME/.config/nvim/init.vim $BKP/init.vim_$DATE
    [[ -f $HOME/.vimrc ]] && cp $HOME/.vimrc $BKP/vimrc_$DATE
    [[ -f $HOME/.vim/coc-settings.json ]] && cp $HOME/.vimrc $BKP/vim_coc-settings.json_$DATE
    [[ -f $HOME/.config/nvim/coc-settings.json ]] && cp $HOME/.vimrc $BKP/nvim_coc-settings.json_$DATE
    [[ -f $HOME/.tmux.conf ]] && cp $HOME/.tmux.conf $BKP/tmux.conf_$DATE
    [[ -d $HOME/.tmux ]] && cp -r $HOME/.tmux $BKP/tmux_$DATE
    [[ -d $HOME/.bash ]] && cp -r $HOME/.bash $BKP/bash_$DATE
    echo Finish backup files
}

function install_bash() {
    # Create bash dir
    mkdir -p $HOME/.bash/completions
    echo Seting up bash scripts
    read -p "Install for personal or work: " res
    while ! [[ $res =~ ^(personal|work)$ ]]; do
        read -p "Input 'personal' or 'work' only: " res
    done

    cat $SCRIPT_PATH/bash/bashrc >> $HOME/.bashrc
    cp $SCRIPT_PATH/bash/inputrc $HOME/.inputrc
    cp $SCRIPT_PATH/bash/lscolor $HOME/.lscolor
    cp $SCRIPT_PATH/bash/shell/$res/* $BASH_DIR/
    cp $SCRIPT_PATH/bash/shell/completions/* $BASH_DIR/completions/
    if [[ $res == "personal" ]]; then
        # Create script dir
        mkdir -p $HOME/.script/
        cp $SCRIPT_PATH/script/* $SCRIPT_DIR/
    fi
    echo Finish setup bash scripts
}

function install_vim() {
    # Check nvim
    echo Setting up Vim
    if [[ -z $NVIM_PATH ]]; then
        read -p "Using plugins? (yes, no): " res
        while ! [[ $res =~ ^(yes|no)$ ]]; do
            read -p "Input 'yes' or 'no' only: " res
        done

        if [[ $res == "yes" ]]; then
            # Create vim dir
            mkdir -p $HOME/.vim/
            cp $SCRIPT_PATH/vim/has_plugin/vimrc $HOME/.vimrc
            cp $SCRIPT_PATH/vim/has_plugin/coc-settings.json $HOME/.vim/
        else
            mkdir -p $HOME/.vim/colors
            cp $SCRIPT_PATH/vim/no_plugin/vimrc $HOME/.vimrc
            cp $SCRIPT_PATH/vim/no_plugin/edge.vim $HOME/.vim/colors/
        fi
    else
        read -p "Using vim or neovim? " res
        while ! [[ $res =~ ^(vim|neovim)$ ]]; do
            read -p "Input 'vim' or 'neovim' only: " res
        done
        
        read -p "Using plugins? (yes, no): " plugin
        while ! [[ $plugin =~ ^(yes|no)$ ]]; do
            read -p "Input 'yes' or 'no' only: " plugin
        done

        if [[ $res == "vim" ]]; then
            if [[ $plugin == "yes" ]]; then
                # Create vim dir
                mkdir -p $HOME/.vim/
                cp $SCRIPT_PATH/vim/has_plugin/vimrc $HOME/.vimrc
                cp $SCRIPT_PATH/vim/has_plugin/coc-settings.json $HOME/.vim/
            else
                mkdir -p $HOME/.vim/colors
                cp $SCRIPT_PATH/vim/no_plugin/vimrc $HOME/.vimrc
                cp $SCRIPT_PATH/vim/no_plugin/edge.vim $HOME/.vim/colors/
            fi
        else
            if [[ $plugin == "yes" ]]; then
                # Create nvim dir
                mkdir -p $HOME/.config/nvim
                cp $SCRIPT_PATH/vim/has_plugin/vimrc $HOME/.config/nvim/init.vim
                cp $SCRIPT_PATH/vim/has_plugin/coc-settings.json $HOME/.config/nvim/coc-settings.json
            else
                mkdir -p $HOME/.config/nvim/colors
                cp $SCRIPT_PATH/vim/no_plugin/vimrc $HOME/.config/nvim/init.vim
                cp $SCRIPT_PATH/vim/no_plugin/edge.vim $HOME/.config/nvim/colors/
            fi
        fi
    fi
    echo Finish setup Vim
}

function install_tmux() {
    echo Setting up Tmux
    # Create tmux dir
    mkdir -p $HOME/.tmux/scripts/../themes

    # Checking tmux version
    if [[ "$(echo "$TMUX_VER >= 3.2" | bc)" == 1 ]]; then
        cp $SCRIPT_PATH/tmux/.tmux.conf $HOME/.tmux.conf
        cp -r $SCRIPT_PATH/tmux/scripts/* $TMUX_DIR/scripts/
        cp -r $SCRIPT_PATH/tmux/themes/* $TMUX_DIR/themes/
    elif [[ "$(echo "$TMUX_VER < 3.2" | bc)" == 1 ]]; then
        echo "Update tmux >= 3.2 please!"
    else
        echo "Tmux not found!"
    fi
    echo Finish setup Tmux
}

function install_config() {
    echo Installing git config
    cp $SCRIPT_PATH/gitconfig $HOME/.gitconfig
    echo Finish git config
}

# Main
if grep "\# dotfile - Start" $HOME/.bashrc > /dev/null ; then
    echo "You have already installed!"
    exit
fi

backup  # safety first! Backup before installing
install_bash
install_vim
install_tmux
install_config
