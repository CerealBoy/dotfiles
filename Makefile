PWD=`pwd`
SLOCK="/usr/local/bin/slock"
ROFI="/usr/local/bin/rofi"
OS=$(shell uname | tr '[:upper:]' '[:lower:]')
GOPKG=go1.12.7.$(OS)-amd64.tar.gz

all: packages configs
	reset

osx: icdiff powerline direnv uscripts

direnv:
	if [ "$(OS)" = "linux" ]; then \
		curl -sL https://github.com/direnv/direnv/releases/download/v2.17.0/direnv.linux-amd64 | \
		sudo tee /usr/local/bin/direnv > /dev/null && \
		sudo chmod a+rx /usr/local/bin/direnv; \
	else \
		curl -sL https://github.com/direnv/direnv/releases/download/v2.17.0/direnv.darwin-amd64 | \
		sudo tee /usr/local/bin/direnv > /dev/null && \
		sudo chmod a+rx /usr/local/bin/direnv; \
	fi

uscripts:
	for file in $(shell ls -1 ./scripts/); do \
		sudo ln $(PWD)/scripts/$${file} /usr/local/bin/$${file}; \
		sudo chmod a+x /usr/local/bin/$${file}; \
	done

submodules:
	git submodule init
	git submodule update --remote --recursive

packages: keys sources debs docker-fix powerline curls

keys:
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv CF8E292A
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -

sources:
	echo "deb http://repo.pritunl.com/stable/apt xenial main" | sudo tee /etc/apt/sources.list.d/pritunl.list > /dev/null
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
	echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable" | sudo tee /etc/apt/sources.list.d/docker.list
	echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list

debs:
	sudo apt update
	sudo apt -y install cowsay curl direnv docker-ce fortune-mod git i3lock libssl-dev m4 ocaml opam pkg-config plank pritunl-client-gtk python-pip rofi scrot signal-desktop spotify-client vim-gtk3 xbacklight
	sudo apt -y upgrade
	wget -O ./code.deb https://go.microsoft.com/fwlink/?LinkID=760868 && \
		sudo dpkg -i ./code.deb && \
		rm ./code.deb

docker-fix:
	sudo gpasswd -a `whoami` docker
	sudo service docker restart
	newgrp docker

curls: icdiff atom go opam docker-compose

powerline:
	if [ "$(OS)" = "linux" ]; then \
		sudo apt -y install fonts-powerline; \
	else \
		cd powerline/fonts && sudo ./install.sh; \
		cd ../..; \
	fi
	cd powerline/shell && sudo python setup.py install

icdiff:
	curl -s https://raw.githubusercontent.com/jeffkaufman/icdiff/release-1.9.0/icdiff | \
    	sudo tee /usr/local/bin/icdiff > /dev/null && \
    	sudo chmod a+rx /usr/local/bin/icdiff
	curl -s https://raw.githubusercontent.com/jeffkaufman/icdiff/release-1.9.0/git-icdiff | \
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
	curl -sLO https://storage.googleapis.com/golang/$(GOPKG)
	sudo rm -rf /opt/go
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
	/opt/go/bin/go get -u github.com/golang/dep/...

opam:
	opam init -n
	opam install spotify-cli -y

docker-compose:
	wget -O ./docker-compose "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m`"
	chmod a+x ./docker-compose
	sudo mv ./docker-compose /usr/local/bin/docker-compose

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
	cp -r "$(PWD)/.config" ~/.config

slock:
	if [ -f "$(SLOCK)" ]; then \
		sudo rm "$(SLOCK)"; \
	fi && sudo ln -s "$(PWD)/slock" "$(SLOCK)"

rofi:
	if [ -f "$(ROFI)" ]; then \
		sudo rm "$(ROFI)"; \
	fi && sudo ln -s "$(PWD)/rofi" "$(ROFI)"

nodejs:
	curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
	curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
	sudo apt-get update && sudo apt-get -y install nodejs yarn

git-heatmap:
	sudo ln -s `pwd`/git-heatmap/git-heatmap /usr/local/bin/git-heatmap

helm:
	if [ "$(OS)" = "linux" ]; then \
		wget -O ./helm.tar.gz https://storage.googleapis.com/kubernetes-helm/helm-v2.13.0-linux-amd64.tar.gz; \
		wget -O ./helmfile https://github.com/roboll/helmfile/releases/download/v0.45.1/helmfile_linux_amd64; \
	else \
		wget -O ./helm.tar.gz https://storage.googleapis.com/kubernetes-helm/helm-v2.13.0-darwin-amd64.tar.gz; \
		wget -O ./helmfile https://github.com/roboll/helmfile/releases/download/v0.45.1/helmfile_darwin_amd64; \
	fi
	tar -xzf ./helm.tar.gz && rm ./helm.tar.gz
	sudo mv ./*-amd64/*l* /usr/local/bin/
	rm -r ./*-amd64/
	chmod a+x helmfile && sudo mv helmfile /usr/local/bin/helmfile

alacritty:
	if [ "$(OS)" = "linux" ]; then \
		wget -O ./alacritty.tar.gz https://github.com/jwilm/alacritty/releases/download/v0.2.3/Alacritty-v0.2.3-x86_64.tar.gz; \
		tar -xzf ./alacritty.tar.gz; \
		sudo mv ./alacritty /usr/local/bin/alacritty; \
		rm ./alacritty.tar.gz; \
	fi

.PHONY: powerline rofi slock git-heatmap
