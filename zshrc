# Personal/public zsh config, safe to source from any machine's ~/.zshrc.
# Employer- or machine-specific setup (PATH additions, work tool env vars,
# etc.) belongs in ~/.zshrc itself, placed AFTER sourcing this file.
#
# To wire this up on a new laptop:
#   1. Clone/symlink this dotfiles repo (see _make_symlinks.sh)
#   2. Add to the top of ~/.zshrc:
#        source ~/tree/dotfiles/zshrc
#   3. Add any machine-specific env vars/PATH/managed blocks below that

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load.
ZSH_THEME="robbyrussell"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="$PATH:$HOME/bin"

# Personal aliases/secrets, kept outside the public dotfiles repo
[[ -f ~/.secretrc ]] && source ~/.secretrc
[[ -f ~/.aliases ]] && source ~/.aliases
[[ -f ~/.aliases_local ]] && source ~/.aliases_local

# up/down history searching
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

lastdl () { echo "~/Downloads/$(ls -tr ~/Downloads/|tail -1)" }

function ldown () {
  local file=~/Downloads/$(ls -1t ~/Downloads/ | head -n1)
  echo $file
}
