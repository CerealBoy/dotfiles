#!/bin/bash

# bring in any submodule updates
git submodule init && git submodule update --remote --recursive

# install direnv, probably need sudo...
cd direnv
make direnv
sudo cp direnv /usr/local/bin/direnv
sudo chmod a+x /usr/local/bin/direnv
cd ..

# install icdiff
cd icdiff
sudo cp *cdiff /usr/local/bin/
sudo chmod a+x /usr/local/bin/*cdiff
cd ..

# remove the old files
rm -rf ~/.vim ~/.vimrc ~/.bashrc ~/.bash_profile ~/.inputrc ~/.gitconfig ~/.profile ~/.screenrc ~/.atom

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
