# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# HISTTIMEFORMAT=" %T "

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
HISTTIMEFORMAT='%d-%m-%y %T %p  '

source ~/dotfiles/shell/prompts/prompt.sh

set -o vi

alias c='clear'
alias x='clear'
alias xxx='exit'
alias ls='ls --color=always'
alias ll='ls -alh --color=always'
alias opn='OpenPath'
alias cppath='CopyPWDPath'
alias hx='helix'
alias zl='zellij'
alias bashrc="hx ~/.bashrc"
alias refresh="source ~/.bashrc"

alias gst='git status'
alias glo='git log --oneline'
alias gcl="git config --list"
alias gcgl="git config --global --list"

alias nst='npm start'
alias nbld='npm run build'
alias ndv='npm run dev'

alias zle='zellij edit'
alias zlef='zellij edit --floating'
alias zlcode='zellij --layout ~/dotfiles/zellij/code.kdl'

ld(){
	ll -pA --color=always | grep '/$' | sed 's/\///'
}
lf(){
	ll -pA --color=always | grep -v '/$'
}

CopyPWDPath(){
	if [ -z $1 ]
	then
		pwd | tr '\n' ' ' | sed s/\\/home\\/$USER/~/ | xclip -selection clipboard
	else
		pwd | tr '\n' ' ' | xclip -selection clipboard
	fi
}

OpenPath(){
	if [ -z $1 ]
	then
		xdg-open .
	else
		xdg-open $1
	fi
}

# tab completion forward and backwards
bind 'TAB:menu-complete'
bind '"\e[Z": menu-complete-backward'    # shift+tab

# if multiple completions available, list them
bind 'set show-all-if-ambiguous on'

# if multiple completions and no partial completion can be made
bind "set show-all-if-unmodified on"

# tab completion options set color 
bind 'set colored-stats on'
bind 'set visible-stats on'

# case insensitive completion
bind "set completion-ignore-case on"

# Perform partial (common) completion on the first Tab press, only start
# cycling full results on the second Tab press (from bash version 5)
bind "set menu-complete-display-prefix on"

# Cycle through history based on characters already typed on the line
bind '"\e[A":history-search-backward'    # uparrow
bind '"\e[B":history-search-forward'     # downarrow
