# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignorespace:erasedups       # ignorespace/ignoredups/ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

HISTSIZE=2000
HISTFILESIZE=10000
HISTTIMEFORMAT='%d-%m-%y %T %p  '

[ -e ~/dotfiles/bash/prompt.sh ] && source ~/dotfiles/bash/prompt.sh
[ -e ~/dotfiles/bash/aliases.sh ] && source ~/dotfiles/bash/aliases.sh
[ -e ~/dotfiles/bash/nvm.sh ] && source ~/dotfiles/bash/nvm.sh

# if the shell is interactive
if [[ $- =~ i ]]; then

  [ -e ~/bin/tmux-sm ] && bind '"\C-b":"\C-E\C-U tmux-sm\n"'
  which lazygit &> /dev/null && bind '"\C-g":"\C-E\C-U lazygit\n"'

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
  bind '"\C-p":history-search-backward'
  bind '"\C-n":history-search-forward'
fi

