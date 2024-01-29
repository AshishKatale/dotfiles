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

alias nst='npm start'
alias nbld='npm run build'
alias ndv='npm run dev'

alias ta='tmux attach -t'
alias tls='tmux list-sessions'
alias tks='tmux kill-session -t'
alias tkill='tmux kill-server'
function tns(){
  session_name=${1:-$(PROMPT_STYLE=plain pathinfo)}
  cwd=${PWD:-$1}
  if ! tmux has-session -t $session_name 2> /dev/null; then
      tmux new-session -ds $session_name -c $cwd
  fi
  if tmux ls | grep attached &> /dev/null; then
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

function v() { 
  if hash nvim &> /dev/null; then 
    nvim $@
  elif hash vim &> /dev/null; then
    vim $@
  elif hash vi &> /dev/null; then
    vi $@
  fi
}

function http-server() {
  python3 -m http.server ${PORT:-3000}
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
