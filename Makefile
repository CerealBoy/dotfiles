PWD=`pwd`
SLOCK="/usr/local/bin/slock"
ROFI="/usr/local/bin/rofi"
GOPKG="go1.8.linux-amd64.tar.gz"

all: packages configs
	reset

submodules:
	git submodule update --remote --recursive

packages: keys sources debs docker-fix powerline curls

keys:
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv CF8E292A
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sources:
	echo "deb http://repo.pritunl.com/stable/apt xenial main" | sudo tee /etc/apt/sources.list.d/pritunl.list > /dev/null
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
	echo "deb https://download.docker.com/linux/ubuntu xenial stable" | sudo tee /etc/apt/sources.list.d/docker.list

debs:
	sudo apt update
	sudo apt -y install cowsay curl direnv docker-ce fortune git i3lock ocaml opam plank pritunl-client-gtk rofi scrot spotify-client vim-gtk3 xbacklight
	sudo apt -y upgrade

docker-fix:
	sudo gpasswd -a `whoami` docker
	sudo service docker restart
	newgrp docker

curls: icdiff atom go opam docker-compose

powerline:
	cd powerline/fonts && chmod a+x ./install.sh && ./install.sh && cd ../..
	cd powerline/shell && chmod a+x ./install.py && ./install.py && cd ../..
	rm ~/.powerline.py && ln -s $(PWD)/powerline/shell/powerline-shell.py ~/.powerline.py

icdiff:
	curl -s https://raw.githubusercontent.com/jeffkaufman/icdiff/release-1.8.1/icdiff | \
    	sudo tee /usr/local/bin/icdiff > /dev/null && \
    	sudo chmod a+rx /usr/local/bin/icdiff
	curl -s https://raw.githubusercontent.com/jeffkaufman/icdiff/release-1.8.1/git-icdiff | \
    	sudo tee /usr/local/bin/git-icdiff > /dev/null && \
    	sudo chmod a+rx /usr/local/bin/git-icdiff

atom: atom-pkg

atom-pkg:
	wget -O ./atom.deb https://atom.io/download/deb && \
		sudo dpkg -i ./atom.deb && \
		rm ./atom.deb

atom-deps:
	apm install autocomplete-elixir go-debug go-plus gtk-dark-theme language-docker language-elixir \
		language-javascript-jsx linter linter-elixirc monokai vim-mode-plus vim-mode-plus-ex-mode
	apm install seti-ui monokai wombat-dark-syntax

go: go-pkg go-deps

go-pkg:
	wget https://storage.googleapis.com/golang/$(GOPKG)
	sudo tar -xzf $(GOPKG) -C /opt
	rm $(GOPKG)

go-deps:
	/opt/go/bin/go get -u github.com/nsf/gocode
	/opt/go/bin/go get -u github.com/axw/gocov/gocov
	/opt/go/bin/go get -u gopkg.in/matm/v1/gocov-html
	/opt/go/bin/go get -u github.com/zmb3/gogetdoc
	/opt/go/bin/go get -u golang.org/x/tools/cmd/goimports
	/opt/go/bin/go get -u gopkg.in/alecthomas/gometalinter.v1
	/opt/go/bin/go get -u sourcegraph.com/sqs/goreturns
	/opt/go/bin/go get -u github.com/kardianos/govendor
	/opt/go/bin/go get -u github.com/mvdan/interfacer/cmd/interfacer
	/opt/go/bin/go get -u github.com/golang/dep/...

opam:
	opam init -n
	opam install spotify-cli -y

docker-compose:
	curl -L https://github.com/docker/compose/releases/download/1.11.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose

configs: links slock rofi

links:
	if [ -d ~/.vim -o -f ~/.gitconfig ]; then \
		(rm -r ~/.vim ~/.vimrc ~/.bashrc ~/.bash_profile ~/.inputrc ~/.gitconfig ~/.profile ~/.screenrc; ~/.atom/config.cson > /dev/null 2>&1) \
	fi
	ln -s "$(PWD)/.vim" ~/.vim
	ln -s "$(PWD)/.vim/vimrc" ~/.vimrc
	ln -s "$(PWD)/.bashrc" ~/.bashrc
	ln -s "$(PWD)/.bash_profile" ~/.bash_profile
	ln -s "$(PWD)/.inputrc" ~/.inputrc
	ln -s "$(PWD)/.gitconfig" ~/.gitconfig
	ln -s "$(PWD)/.profile" ~/.profile
	ln -s "$(PWD)/.screenrc" ~/.screenrc
	ln -s "$(PWD)/.atom.config.cson" ~/.atom/config.cson
	cp -r "$(PWD)/.config" ~/.config

slock:
	if [ -f "$(SLOCK)" ]; then \
		sudo rm "$(SLOCK)"; \
	fi && sudo ln -s "$(PWD)/slock" "$(SLOCK)"

rofi:
	if [ -f "$(ROFI)" ]; then \
		sudo rm "$(ROFI)"; \
	fi && sudo ln -s "$(PWD)/rofi" "$(ROFI)"

.PHONY: powerline rofi slock
