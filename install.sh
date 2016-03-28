#!/bin/bash

git submodule init && git submodule update

rm -rf ~/.vim ~/.vimrc ~/.bashrc ~/.bash_profile ~/.inputrc ~/.gitconfig ~/.profile ~/.screenrc ~/.atom

ln -s "$PWD/.vim" ~/.vim
ln -s "$PWD/.vim/vimrc" ~/.vimrc
ln -s "$PWD/.bashrc" ~/.bashrc
ln -s "$PWD/.bash_profile" ~/.bash_profile
ln -s "$PWD/.inputrc" ~/.inputrc
ln -s "$PWD/.gitconfig" ~/.gitconfig
ln -s "$PWD/.profile" ~/.profile
ln -s "$PWD/.screenrc" ~/.screenrc
ln -s "$PWD/.atom" ~/.atom
