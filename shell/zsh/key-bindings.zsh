# All bindings can be found https://www.zsh.org/mla/users/2014/msg00266.html

# Reverse_search keybinding

_reverse_search(){
	# local selected_command=$(fc -rl 1 | awk '{$1="";print substr($0,2)}' | fzf)
	local selected_command=$(fc -rl 1 | awk '{$1="";print substr($0,2)}' | awk '!seen[$0]++' | fzf)
  LBUFFER=$selected_command
}

zle -N  _reverse_search
bindkey '^r'  _reverse_search
