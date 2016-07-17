#!/bin/bash

# bring in any submodule updates
git submodule init && git submodule update --remote --recursive

# get some more packages in here
echo "deb http://repo.pritunl.com/stable/apt xenial main" | sudo tee /etc/apt/sources.list.d/pritunl.list > /dev/null
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv CF8E292A

# use the apt direnv package
sudo apt update
sudo apt -y install direnv plank pritunl-client-gtk synapse
sudo apt -y upgrade

# install icdiff
cd icdiff
sudo cp *cdiff /usr/local/bin/
sudo chmod a+x /usr/local/bin/*cdiff
cd ..

# remove the old files
if [ -f ~/.vim && -f ~/.gitconfig ]; then
	rm ~/.vim ~/.vimrc ~/.bashrc ~/.bash_profile ~/.inputrc ~/.gitconfig ~/.profile ~/.screenrc;
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

# use the profile pls
. ~/.bash_profile

# bring in atom
#wget https://atom.io/download/deb
#sudo dpkg -i ./atom-amd64.deb

# grab the latest golang
GO_PKG="go1.6.2.linux-amd64.tar.gz"
wget https://storage.googleapis.com/golang/$GO_PKG
sudo tar -xzf $GO_PKG -C /opt

# install some golang tools
go get -u golang.org/x/tools/cmd/goimports
go get -u github.com/alecthomas/gometalinter

