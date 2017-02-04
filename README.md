# dotfiles
My repository for environment setup and dotfiles

## configurations
Application settings are kept for *vim* and *atom*, both have their uses. At the present time, *screen* is my
preferred windower but I have been looking into *tmux* a little, just no confidence. Input mode has been changed
to *vi*, such flexibility!

## updating
The *vim* plugins are embedded as git submodules, these can be recursively updated in the usual method. Move into
the root folder of this repository, and run:

    make submodules

## installation
A comprehensive make target is available to complete all tasks. This includes adding repositories, installing packages
via apt, setting up config files, downloading tarballs, and any other appropriate installations.

    make all

### targets
* ``make packages`` will bring in all packages from all sources
  * ``make go`` will install go and general tools used
  * ``make atom`` will install atom and bring in requirements for configurations used
  * ``make powerline`` will grab powerline for pretty shell display
  * ``make icdiff`` retrieves and enables icdiff
  * ``make opam`` installs opam and the spotify-cli client
  * ``make keys sources debs`` installs apt packages, for the following
    * cowsay
    * direnv
    * fortune
    * i3lock
    * ocaml
    * opam
    * plank
    * pritunl-client-gtk
    * rofi
    * scrot
    * spotify-client
  * ``make rofi`` pushes the ready-made rofi script to the path
  * ``make slock`` sets up the custom lock screen
* ``make configs`` will setup the configuration requiremets for the packages

