alias v="nvim"
alias c="clear"
alias x="clear"
alias ccc="exit"
alias xxx="exit"
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias bashrc="vim ~/.bashrc"
alias zshrc="vim $ZDOTDIR/.zshrc"

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
alias zlp='zellij -l ~/dotfiles/zellij/.config/zellij/plain.kdl'
alias zlcode='zellij --layout ~/dotfiles/zellij/.config/zellij/code.kdl'

function ll() { ls -Alh --color=always $@ }
function lsf() { ls --color=always -alhA $@ | grep --color=never -v "^d.*" }
function lsd() { ls --color=always -alhA $@ | grep --color=never "^d.*" }

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
