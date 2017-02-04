PWD=`pwd`
SLOCK="/usr/local/bin/slock"
ROFI="/usr/local/bin/rofi"
GOPKG="go1.7.4.linux-amd64.tar.gz"

all: packages configs
	reset

submodules:
	git submodule update --remote --recursive

packages: keys sources debs powerline curls

keys:
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv CF8E292A
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886

sources:
	echo "deb http://repo.pritunl.com/stable/apt xenial main" | sudo tee /etc/apt/sources.list.d/pritunl.list > /dev/null
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

debs:
	sudo apt update
	sudo apt -y install cowsay direnv fortune i3lock ocaml opam plank pritunl-client-gtk rofi scrot spotify-client
	sudo apt -y upgrade

curls: icdiff atom go opam

powerline:
	cd powerline/fonts && ./install.sh && cd ../..
	cd powerline/shell && ./install.py && cd ../..
	ln -s $(PWD)/powerline/shell/powerline-shell.py ~/.powerline.py

icdiff:
	curl -s https://raw.githubusercontent.com/jeffkaufman/icdiff/release-1.8.1/icdiff | \
    	sudo tee /usr/local/bin/icdiff > /dev/null && \
    	sudo chmod a+rx /usr/local/bin/icdiff
	curl -s https://raw.githubusercontent.com/jeffkaufman/icdiff/release-1.8.1/git-icdiff | \
    	sudo tee /usr/local/bin/git-icdiff > /dev/null && \
    	sudo chmod a+rx /usr/local/bin/git-icdiff

atom:
	wget -O ./atom.deb https://atom.io/download/deb && \
		sudo dpkg -i ./atom.deb && \
		rm ./atom.deb

go: go-pkg go-deps

go-pkg:
	wget https://storage.googleapis.com/golang/$(GOPKG)
	sudo tar -xzf $(GOPKG) -C /opt

go-deps:
	go get -u github.com/nsf/gocode
	go get -u github.com/axw/gocov/gocov
	go get -u gopkg.in/matm/v1/gocov-html
	go get -u github.com/zmb3/gogetdoc
	go get -u golang.org/x/tools/cmd/goimports
	go get -u gopkg.in/alecthomas/gometalinter.v1
	go get -u sourcegraph.com/sqs/goreturns
	go get -u github.com/kardianos/govendor
	go get -u github.com/mvdan/interfacer/cmd/interfacer

opam:
	opam init -n
	opam install spotify-cli -y

configs: links slock rofi

links:
	if [ -f ~/.vim -a -f ~/.gitconfig ]; then \
		rm ~/.vim ~/.vimrc ~/.bashrc ~/.bash_profile ~/.inputrc ~/.gitconfig ~/.profile ~/.screenrc; \
	fi
	ln -s "$(PWD)/.vim" ~/.vim
	ln -s "$(PWD)/.vim/vimrc" ~/.vimrc
	ln -s "$(PWD)/.bashrc" ~/.bashrc
	ln -s "$(PWD)/.bash_profile" ~/.bash_profile
	ln -s "$(PWD)/.inputrc" ~/.inputrc
	ln -s "$(PWD)/.gitconfig" ~/.gitconfig
	ln -s "$(PWD)/.profile" ~/.profile
	ln -s "$(PWD)/.screenrc" ~/.screenrc
	cp -r "$(PWD)/.config" ~/.config

slock:
	if [ -f "$(SLOCK)" ]; then \
		sudo rm "$(SLOCK)"; \
	fi && sudo ln -s "$(PWD)/slock" "$(SLOCK)"

rofi:
	if [ -f "$(ROFI)" ]; then \
		sudo rm "$(ROFI)"; \
	fi && sudo ln -s "$(PWD)/rofi" "$(ROFI)"

.PHONY: powerline
