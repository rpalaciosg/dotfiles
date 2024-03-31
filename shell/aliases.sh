# Enable aliases to be sudo’ed
alias sudo='sudo '

alias ..="cd .."
alias ...="cd ../.."
alias ls='lsd --group-directories-first -g -t -G -S -F'                                      #'colorls --group-directories-first --gs -t'
alias l='lsd --group-directories-first -g -A -t -G -S -F'                                    #'colorls --group-directories-first --gs -t'
alias ll='lsd --group-directories-first -g -A -t -G -S -F --blocks name,size,git,permission' #'colorls --group-directories-first --almost-all --gs -t'
alias la='lsd --group-directories-first -a -g -t -G -S -F --long'                            #'colorls --group-directories-first --almost-all --long --gs -t' # detailed list view
alias lt='lsd --tree --depth 2 --blocks name,size,git,permission -gtGSF'
alias ~="cd ~"
alias dotfiles='cd $DOTFILES_PATH'

# Cat or bat
alias cat="batcat"

# Nvim or vim
alias vim="nvim"
alias nvim="nvim"
alias vi="nvim"
alias lv="nvim"

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
alias gtl='cd /home/richard/Learning'
