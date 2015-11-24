#!/bin/bash

git submodule update --init
./brew.sh
./_make_symlinks.sh
./_osx_defaults.sh
