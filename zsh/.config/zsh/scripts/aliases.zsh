alias c="clear"
alias x="clear"
alias ccc="exit"
alias xxx="exit"
alias ls="ls --color=always"
alias ll="ls -alh --color=always"
alias stow='stow --no-folding'
alias refresh="source $ZDOTDIR/.zshrc"

alias gst='git status'
alias glo='git log --oneline'
alias gcl="git config --list"
alias gcm="git commit -m"
alias gamend="git commit --amend --no-edit"
alias gcgl="git config --global --list"

alias nst='npm start'
alias nbld='npm run build'
alias ndv='npm run dev'

alias zl='zellij'
alias zled='zellij edit'
alias zlef='zellij edit --floating'
alias zlcode='zellij --layout ~/dotfiles/zellij/code.kdl'

function lsf() { ls -alhpA $1 | grep -v ".*/" }
function lsd() { ls -alhpA $1 | grep ".*/" | sed "s/\///" }

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

