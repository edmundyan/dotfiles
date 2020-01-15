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
brew install git
brew install python@2
brew install vim
brew install tmux
brew install pyenv
brew install pyenv-virtualenv
brew install the_silver_searcher

brew install caskroom/cask/brew-cask

brew cask install bartender
brew cask install iterm2
brew cask install slate
brew cask install 1password-cli
