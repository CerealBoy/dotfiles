# dotfiles
My repository for environment setup and dotfiles

## configurations
Application settings are kept for *vim* and *atom*, both have their uses. At the present time, *screen* is my
preferred windower but I have been looking into *tmux* a little, just no confidence. Input mode has been changed
to *vi*, such flexibility!

## updating
The *vim* plugins are embedded as git submodules, these can be recursively updated in the usual method. Move into
the root folder of this repository, and run:

    git submodule update --remote --recursive

## installation
The included *install.sh* script will complete installation. Beware however, it will delete any existing files in
the paths of the included files.
