#!/bin/sh

[ ! -e ~/.bashrc ] && ln -s ~/dotfiles/shells/bashrc .bashrc
[ ! -e ~/.bash_profile ] && ln -s ~/dotfiles/shells/bash_profile .bash_profile
#[ ! -e ~/.inputrc ] && ln -s ~/dotfiles/shells/inputrc .inputrc
[ ! -d ~/tmp ] && mkdir ~/tmp
[ ! -e ~/.vimrc ] && ln -s ~/dotfiles/editors/vimrc .vimrc
[ ! -e ~/.gitconfig ] && ln -s ~/dotfiles/utils/gitconfig .gitconfig
[ ! -e ~/.gitignore_global ] && ln -s ~/dotfiles/utils/gitignore_global .gitignore_global
[ ! -e ~/.editorconfig ] && ln -s ~/dotfiles/editors/editorconfig .editorconfig