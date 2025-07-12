function cdd() {
  cd "$(ls -d -- */ | fzf)" || echo "Invalid directory"
}

function j() {
  fname=$(declare -f -F _z)

  [ -n "$fname" ] || source "$DOTLY_PATH/modules/z/z.sh"

  _z "$1"
}

function recent_dirs() {
  # This script depends on pushd. It works better with autopush enabled in ZSH
  escaped_home=$(echo $HOME | sed 's/\//\\\//g')
  selected=$(dirs -p | sort -u | fzf)

  cd "$(echo "$selected" | sed "s/\~/$escaped_home/")" || echo "Invalid directory"
}

function zsh_stats() {
  fc -l 1 | awk '{CMD[$2]++;count++;} END { for (a in CMD)	print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n25
}

function gc {
  git add -A

  if [ -z "$1" ]; then
    git commit - S
  else
    git commit -S -m"$1"
  fi
}

# --- Yazi Setup ---
function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

function tmuxas() {
  # Listar sesiones de tmux y pasarlas a fzf
  session=$(tmux ls | awk '{print $1}' | fzf --height 40% --reverse)

  # Comprobar si se seleccionó una sesión
  if [ -n "$session" ]; then
    # Adjuntar a la sesión seleccionada
    tmux attach-session -t "$session"
  else
    echo "No se seleccionó ninguna sesión."
  fi

}
