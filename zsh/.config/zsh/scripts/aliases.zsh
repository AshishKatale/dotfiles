alias c="clear"
alias x="clear"
alias ccc="exit"
alias xxx="exit"
alias ls="ls --color=auto"
alias ll="ls -alh --color=auto"
alias grep="grep --color=auto"
alias bashrc="vim ~/.bashrc"
alias zshrc="vim $ZDOTDIR/.zshrc"

alias gst='git status'
alias glo='git log --oneline'
alias glog='git log --oneline --graph --all --decorate=full'
alias gcl="git config --list"
alias gcm="git commit -m"
alias gamend="git commit --amend --no-edit"
alias gcgl="git config --global --list"

alias nst='npm start'
alias nbld='npm run build'
alias ndv='npm run dev'

alias tls='tmux list-sessions'
alias tks='tmux kill-session -t'
alias tkill='tmux kill-server'
alias ta='tmux attach -t'

function ll() { ls -Alh --color=always $@ }
function lsf() { ls --color=always -alhA $@ | grep --color=never -v "^d.*" }
function lsd() { ls --color=always -alhA $@ | grep --color=never "^d.*" }
function v() { if hash nvim &> /dev/null; then nvim $@; else vim $@; fi }

function http-server() {
  PORT=$1
  [ -z "$PORT" ] && PORT=8080
  python3 -m http.server $PORT
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
