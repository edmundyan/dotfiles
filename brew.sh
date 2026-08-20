#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure we’re using the latest Homebrew.
brew update


# tmux copy+paste
brew install reattach-to-user-namespace

# essential crap
brew install vim
brew install tmux
brew install ripgrep
brew install fd

# nerd font w/ powerline glyphs, needed for vim-airline/tmux statusline symbols
# (after installing, set it as your terminal's font)
brew install --cask font-meslo-lg-nerd-font

