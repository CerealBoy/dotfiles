#!/bin/bash

# bring in any submodule updates
git submodule init && git submodule update --remote --recursive

# use the apt direnv package
sudo apt update
sudo apt -y install direnv synapse

# install icdiff
cd icdiff
sudo cp *cdiff /usr/local/bin/
sudo chmod a+x /usr/local/bin/*cdiff
cd ..

# remove the old files
if [ -f ~/.vim && -f ~/.gitconfig ]; then
	rm ~/.vim ~/.vimrc ~/.bashrc ~/.bash_profile ~/.inputrc ~/.gitconfig ~/.profile ~/.screenrc ~/.atom;
fi

# symlink them in
ln -s "$PWD/.vim" ~/.vim
ln -s "$PWD/.vim/vimrc" ~/.vimrc
ln -s "$PWD/.bashrc" ~/.bashrc
ln -s "$PWD/.bash_profile" ~/.bash_profile
ln -s "$PWD/.inputrc" ~/.inputrc
ln -s "$PWD/.gitconfig" ~/.gitconfig
ln -s "$PWD/.profile" ~/.profile
ln -s "$PWD/.screenrc" ~/.screenrc
ln -s "$PWD/.atom" ~/.atom

# use the profile pls
. ~/.bash_profile

