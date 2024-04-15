#!/usr/bin/env sh

git clone --recursive https://github.com/Lu-ni/dotvim.git ~/.vim
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -s ~/.vim/vimrc ~/.vimrc
vim -c ":PluginInstall" -c ":qa"
