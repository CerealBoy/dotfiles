# dotfiles

My repository for environment setup and dotfiles.

## configurations

These days I'm using `nvim` and `tmux`, their configuration files are kept as part
of this repository. This is all managed by [chezmoi](https://www.chezmoi.io) to give
some flexibility without me implementing a bunch of stuff myself.

## updating

The *vim* plugins are embedded as git submodules, these can be recursively updated
in the usual method.

## macos

For macOS in particular, a `Brewfile` is included. This should only be complimentary
to what's included by `mise`.
