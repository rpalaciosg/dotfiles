# All bindings can be found https://www.zsh.org/mla/users/2014/msg00266.html

# Reverse_search keybinding

_reverse_search(){
	# local selected_command=$(fc -rl 1 | awk '{$1="";print substr($0,2)}' | fzf)
	# local selected_command=$(fc -rl 1 | awk '{$1="";print substr($0,2)}' | awk '!seen[$0]++' | peco)
	local selected_command=$(fc -rl 1 | awk '{$1="";print substr($0,2)}' | awk '!seen[$0]++' | fzf)
  LBUFFER=$selected_command
}

zle -N  _reverse_search
bindkey '^r'  _reverse_search

# Abrir proyectos en vscode
_open_project(){
  # local project=$(ls $HOME/Projects | peco)
  local project=$(ls $HOME/Projects | fzf)
  if [ ! -z $project ]
  then
    cd "$HOME/Projects/$project"
    code .
  fi
}

zle -N _open_project
bindkey "^k" _open_project

# Cambiarme de rama de git
_change_branch() {
  # local branch_name=$(git branch | peco);
  local branch_name=$(git branch | fzf);
  # git checkout "${branch_name##*( )}";
  git switch "${branch_name##*( )}";
}

zle -N _change_branch
bindkey "^b" _change_branch
