# Enable aliases to be sudo’ed
alias sudo='sudo '

alias ..="cd .."
alias ...="cd ../.."
alias l='colorls --group-directories-first --gs -t'
alias ll='colorls --group-directories-first --almost-all --gs -t'
#alias ll="ls -l"
alias la='colorls --group-directories-first --almost-all --long --gs -t' # detailed list view
#alias la="ls -la"
alias ~="cd ~"
alias dotfiles='cd $DOTFILES_PATH'

# Cat or bat
alias cat="batcat"

# Nvim or vim
alias vim="lvim"
alias nvim="nvim"
alias vi="lvim"
alias lv="lvim"

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
alias o.='open .'
alias up='dot package update_all'
#alias code='/usr/share/code'

# customize
alias gtp='cd /home/richard/Projects'
