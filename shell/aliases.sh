#!/bin/zsh
# === Alias personalizados ===

# Conexion trabajo
alias vpnmaz='~/conectar-trabajo.sh'

# Utils
alias k='kill -9'
alias i.='(idea $PWD &>/dev/null &)'
alias c.='(code $PWD &>/dev/null &)'
alias v.='nvim .'
alias o.='open .'

# Cat or bat
alias cat="batcat"

# Nvim or vim
alias vi="nvim"
alias vim="nvim"
alias nvim="nvim"

# Docker
alias dockerps="docker ps --format 'table {{.ID}}\t{{.Status}}\t{{.Names}}\t{{.Image}}'"
alias dockerpsa="docker ps -a --format 'table {{.ID}}\t{{.Status}}\t{{.Names}}\t{{.Image}}'"

# Custom cd
alias gtp='cd $HOME/Projects'
alias gtl='cd $HOME/Learning'

# Reload zshrc
alias zshs='source $HOME/.zshrc'
