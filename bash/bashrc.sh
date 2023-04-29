# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000
HISTTIMEFORMAT='%d-%m-%y %T %p  '

source ~/dotfiles/bash/prompts/prompt.sh

# set -o vi

alias c='clear'
alias x='clear'
alias xxx='exit'
alias ccc='exit'
alias ls='ls --color=auto'
alias ll='ls -alh --color=auto'
alias hx='helix'
alias zl='zellij'
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

alias zle='zellij edit'
alias zlef='zellij edit --floating'
alias zlcode='zellij --layout ~/dotfiles/zellij/.config/zellij/code.kdl'

alias stow='stow --no-folding'

ld(){
	ll -pA $1 --color=always | grep '/$' | sed 's/\///'
}
lf(){
	ll -pA $1 --color=always | grep -v '/$'
}

cppath(){
	if [ -z $1 ]
	then
		pwd | tr '\n' ' ' | sed s/\\/home\\/$USER/~/ | xclip -selection clipboard
	else
		pwd | tr '\n' ' ' | xclip -selection clipboard
	fi
}

opn(){
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
