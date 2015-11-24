#!/bin/bash

git submodule update --init
./brew.sh
./_make_symlinks.sh
./_osx_defaults.sh

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

