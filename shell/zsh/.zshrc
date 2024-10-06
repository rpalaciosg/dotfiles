# Uncomment for debuf with `zprof`
# zmodload zsh/zprof

export ZIM_HOME="${ZDOTDIR:-$HOME}/.dotfiles/modules/dotly/modules/zimfw"
export PATH="$ZIM_HOME:$PATH"


# ZSH Ops
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FCNTL_LOCK
setopt +o nomatch
# setopt autopushd

echo "Cargando Zim..."

# Start zim
# source "$ZIM_HOME/init.zsh"
#source "$ZIM_HOME/zimfw.zsh"
# Initialize Zim
if [[ -s ${ZIM_HOME}/init.zsh ]]; then
  # source "$ZIM_HOME/zimfw.zsh"
fi

# Async mode for autocompletion
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_HIGHLIGHT_MAXLENGTH=300

source "$DOTFILES_PATH/shell/init.sh"

fpath=("$DOTFILES_PATH/shell/zsh/themes" "$DOTFILES_PATH/shell/zsh/autocompletions" "$DOTLY_PATH/shell/zsh/themes" "$DOTLY_PATH/shell/zsh/completions" $fpath)

autoload -Uz promptinit && promptinit
prompt ${DOTLY_THEME:-codely}
# prompt ${DOTLY_THEME:-starship}


source "$DOTLY_PATH/shell/zsh/bindings/dot.zsh"
source "$DOTLY_PATH/shell/zsh/bindings/reverse_search.zsh"
source "$DOTFILES_PATH/shell/zsh/key-bindings.zsh"
export PATH="$PATH:$HOME/bin"

export NVM_DIR="/home/richard/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


export PATH=/home/richard/.local/bin:$PATH

#PATH=~/.console-ninja/.bin:$PATH
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Turso
#export PATH="/home/richard/.turso:$PATH"
eval "$(starship init zsh)"
