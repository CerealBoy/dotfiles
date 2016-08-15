#!/bin/bash

WHOAMI=$(whoami)

# get some more packages in here
echo "deb http://repo.pritunl.com/stable/apt xenial main" | sudo tee /etc/apt/sources.list.d/pritunl.list > /dev/null
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv CF8E292A

# grab and install icdiff
curl -s https://raw.githubusercontent.com/jeffkaufman/icdiff/release-1.8.1/icdiff | \
    sudo tee /usr/local/bin/icdiff > /dev/null && \
    sudo chmod a+rx /usr/local/bin/icdiff
curl -s https://raw.githubusercontent.com/jeffkaufman/icdiff/release-1.8.1/git-icdiff | \
    sudo tee /usr/local/bin/git-icdiff > /dev/null && \
    sudo chmod a+rx /usr/local/bin/git-icdiff

# spotify
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886

# use the apt direnv package
sudo apt update
sudo apt -y install direnv i3lock ocaml opam plank pritunl-client-gtk rofi scrot spotify-client
sudo apt -y upgrade

# init opam
opam init -n

# remove the old files
if [ -f ~/.vim -a -f ~/.gitconfig ]; then
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

# config is a little different
cp -r "$PWD/.config" ~/.config

# use the profile pls
. ~/.bash_profile

# bring in atom
wget https://atom.io/download/deb
sudo dpkg -i ./deb

# lock-screen pls
sudo cp "$PWD/slock" /usr/bin/slock
sudo chown $(WHOAMI):$(WHOAMI) /usr/bin/slock
chmod a+x /usr/bin/slock

# rofi runner also
sudo cp "$PWD/rofi" /usr/local/bin/rofi
sudo chmod a+x /usr/local/bin/rofi

# grab the latest golang
GO_PKG="go1.6.3.linux-amd64.tar.gz"
wget https://storage.googleapis.com/golang/$GO_PKG
sudo tar -xzf $GO_PKG -C /opt

# install some golang tools
go get -u golang.org/x/tools/cmd/goimports
go get -u github.com/alecthomas/gometalinter
go get -u github.com/axw/gocov/gocov
go get -u gopkg.in/matm/v1/gocov-html
go get -u github.com/kardianos/govendor

# spotify-cli
opam install spotify-cli -y

