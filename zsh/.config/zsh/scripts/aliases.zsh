alias c="clear"
alias x="clear"
alias ccc="exit"
alias xxx="exit"
alias ls="ls --color=auto"
alias lls="ls -l --color=auto"
alias ll="ls -alh --color=auto"
alias grep="grep --color=auto"
alias bashrc="vim ~/.bashrc"
alias zshrc="vim $ZDOTDIR/.zshrc"

function ll() { ls -Alh --color=always $@ }
function lsf() { ls --color=always -alhA $@ | grep --color=never -v "^d.*" }
function lsd() { ls --color=always -alhA $@ | grep --color=never "^d.*" }

alias gst='git status'
alias glo='git log --oneline'
alias glog='git log --oneline --graph --all --decorate=full'
alias gcl="git config --list"
alias gcm="git commit -m"
alias gamend="git commit --amend --no-edit"
alias gcgl="git config --global --list"

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

alias ta='tmux attach -t'
alias tls='tmux list-sessions'
alias tks='tmux kill-session -t'
alias tkill='tmux kill-server'
function tns () {
  session_name=${1:-$(PROMPT_STYLE=plain pathinfo)}
  cwd=$(realpath $PWD)
  if [[ $session_name == "~" || $session_name == "~/" ]]; then
    session_name=$HOME
  fi
  if ! tmux has-session -t $session_name 2> /dev/null; then
      tmux new-session -ds $session_name -c $cwd
  fi
  if tmux ls | grep attached &> /dev/null; then
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

function http-server() {
  python3 -m http.server ${1:-3000}
}

function cpwd(){
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

function grab(){
	if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    echo "
Copies the output of command provided as argument to the clipboard.

USAGE:
	grab [command]
	eg.
		grab \"ls -alh\"
		grab \"echo \$PATH | tr ':' '\\\n'\"

OPTIONS:
	-h, --help
		Print help information
"
	else
		eval $1 | tee >(xclip -selection clipboard) 
	fi
}
