alias c="clear"
alias xxx="exit"
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias bashrc="vim $HOME/.bashrc"
alias zshrc="vim $ZDOTDIR/.zshrc"
alias ls='ls --color=auto'

function ll() { ls -Alh --color=always $@ }
function lsf() { ls --color=always -alhA $@ | grep --color=never -v "^d.*" }
function lsd() { ls --color=always -alhA $@ | grep --color=never "^d.*" }

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
function tns() { tmuxsmgr "${1:-$PWD}" }

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

