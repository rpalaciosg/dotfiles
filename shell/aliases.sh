# Enable aliases to be sudo’ed
alias sudo='sudo '

alias ..="cd .."
alias ...="cd ../.."
# alias ls='lsd --group-directories-first -g -t -G -S -F' #'colorls --group-directories-first --gs -t'
alias l='lsd --group-directories-first -g -t -G -S -F --color auto --icon auto' #'colorls --group-directories-first --gs -t'
# alias ll='lsd --group-directories-first -g -A -t -G -S -F --blocks name,size,git,permission' #'colorls --group-directories-first --almost-all --gs -t'
alias ll='lsd --group-directories-first -g -A -t -G -S -F' #'colorls --group-directories-first --almost-all --gs -t'
# alias lt='lsd --tree --depth 2 -gtGSF'
alias lt='lsd --tree --depth 2 --blocks name,size,git,permission -gtGSF'
alias la='lsd --group-directories-first -a -g -t -G -S -F --long' #'colorls --group-directories-first --almost-all --long --gs -t' # detailed list view
alias ~="cd ~"
alias dotfiles='cd $DOTFILES_PATH'

# Cat or bat
alias cat="batcat"

# Nvim or vim
alias vi="nvim"
alias vim="nvim"
alias nvim="nvim"

# Git
alias g="git"
alias gaa="git add -A"
alias gc='$DOTLY_PATH/bin/dot git commit'
alias gca="git add --all && git commit --amend --no-edit"
alias gco="git checkout"
alias gd='$DOTLY_PATH/bin/dot git pretty-diff'
alias gs="git status -sb"
alias gf="git fetch --all -p"
alias gps="git push"
alias gpsf="git push --force"
alias gpl="git pull --rebase --autostash"
alias gb="git branch"
alias gl='$DOTLY_PATH/bin/dot git pretty-log'
alias view-on-gitub=$'xdg-open `git config --get remote.origin.url | awk \'/git@github.com:/ { sub(/git@github.
       │ com:/, "https://github.com/") }; { print }\'`'

# Commitizen
alias cz-friendly="commitizen init cz-conventional-changelog --save-dev --save-exact"

# Utils
alias k='kill -9'
alias i.='(idea $PWD &>/dev/null &)'
alias c.='(code $PWD &>/dev/null &)'
alias v.='nvim .'
alias o.='open .'
alias up='dot package update_all'
alias dockerps="docker ps --format 'table {{.ID}}\t{{.Status}}\t{{.Names}}\t{{.Image}}'"
alias dockerpsa="docker ps -a --format 'table {{.ID}}\t{{.Status}}\t{{.Names}}\t{{.Image}}'"

# customize
alias gtp='cd $HOME/Projects'
alias gtl='cd $HOME/Learning'
# alias cdc='cd $HOME/Code'
alias zshs='source $HOME/.zshrc'
