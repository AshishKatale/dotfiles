alias c='clear'
alias xxx='exit'
alias bashrc="vim ~/.bashrc"
alias ls='ls --color=auto'

function ll() {
	ls -Alh --color=always $@
}
function lsf() {
	ls --color=always -alhA $@ | grep --color=never -v "^d.*"
}
function lsd() {
	ls --color=always -alhA $@ | grep --color=never "^d.*"
}

alias gst='git status'
alias gbr='git branch'
alias gco='git checkout'
alias gpo='git pull origin'
alias glo='git log --oneline'
alias glon='git log --oneline -n'
alias glog='git log --oneline --graph --all --decorate=full'
alias gcl="git config --list"
alias gcm="git commit -m"
alias gcamd="git commit --amend"
alias gcamend="git commit --amend --no-edit"
alias gcgl="git config --global --list"

alias ta='tmux attach -t'
alias tls='tmux list-sessions'
alias tks='tmux kill-session -t'
alias tkill='tmux kill-server'
function tns() {
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
  if [[ $TMUX ]]; then
    tmux switch-client -t $session_name
  else
    tmux attach-session -t $session_name
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
