alias c='clear'
alias x='clear'
alias xxx='exit'
alias ccc='exit'
alias ls='ls --color=auto'
alias ll='ls -alh --color=auto'
alias hx='helix'
alias bashrc="vim ~/.bashrc"

alias gst='git status'
alias glo='git log --oneline'
alias gcl="git config --list"
alias gcm="git commit -m"
alias gamend="git commit --amend --no-edit"
alias gcgl="git config --global --list"

alias ta='tmux attach -t'
alias tls='tmux list-sessions'
alias tks='tmux kill-session -t'
alias tkill='tmux kill-server'
function tns(){
  selected=${1:-$(PROMPT_STYLE=plain pathinfo full)}
  selected_name=$(basename "$selected" | tr . _)
  selected_dirname="$(basename $(dirname $selected) | tr . _)"
  session_name="$selected_dirname/$selected_name"
  cwd=$(realpath $PWD)
  if [[ $session_name == "~" || $session_name == "~/" ]]; then
    session_name=$HOME
  fi
  if ! tmux has-session -t $session_name 2> /dev/null; then
      tmux new-session -ds $session_name -c $cwd
  fi
  if [[ $TMUX ]] then
    tmux switch-client -t $session_name
  else
    tmux attach-session -t $session_name
  fi
}

function ld(){
	ll -pA $1 --color=always | grep '/$' | sed 's/\///'
}
function lf(){
	ll -pA $1 --color=always | grep -v '/$'
}

function nst () {
  if [ -f "pnpm-lock.yaml" ]; then
    echo pnpm dev
    pnpm dev
  elif [ -f "package-lock.json" ]; then
    echo npm start
    npm start
  fi
}
function nbld () {
  if [ -f "pnpm-lock.yaml" ]; then
    echo pnpm build
    pnpm build
  elif [ -f "package-lock.json" ]; then
    echo npm run build
    npm run build
  fi
}
function ndv () {
  if [ -f "pnpm-lock.yaml" ]; then
    echo pnpm host
    pnpm host
  elif [ -f "package-lock.json" ]; then
    echo npm run dev
    npm run dev
  fi
}

function v() { 
  if hash nvim &> /dev/null; then 
    nvim $@
  elif hash vim &> /dev/null; then
    vim $@
  elif hash vi &> /dev/null; then
    vi $@
  fi
}

function serve() {
  python3 -m http.server ${1:-3000}
}

function cppath(){
	if [ -z $1 ]
	then
		pwd | tr '\n' ' ' | sed s/\\/home\\/$USER/~/ | xclip -selection clipboard
	else
		pwd | tr '\n' ' ' | xclip -selection clipboard
	fi
}

function opn(){
	if [ -z $1 ]
	then
		xdg-open .
	else
		xdg-open $1
	fi
}
