# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=5000
HISTTIMEFORMAT='%d-%m-%y %T %p  '

source ~/dotfiles/bash/prompt.sh
source ~/dotfiles/bash/aliases.sh

# if the shell is interactive
if [[ $- =~ i ]]; then

  # enable vi mode for command-line
  set -o vi
  bind -m vi-command '"j": nop'
  bind -m vi-command '"k": nop'
  bind -m vi-insert '"jk":vi-movement-mode'
  bind -m vi-insert '"\C-a":beginning-of-line'
  bind -m vi-insert '"\C-e":end-of-line'
  bind -m vi-insert '"\C-k":kill-line'
  bind -m vi-insert '"\C-l":clear-screen'
  bind -m vi-insert '"\C-w":backward-kill-word'
  bind -m vi-insert '"\C-u":backward-kill-line'
  bind -m vi-insert '"\e-w":emacs-forward-word'
  bind -m vi-insert '"\e-b":emacs-backward-word'
  bind -m vi-insert '"\C-b":"tmux-sessionizer\n"'
  bind -m vi-insert '"\C-p":history-search-backward'
  bind -m vi-insert '"\C-n":history-search-forward'

  # Set show-mode-in-prompt option
  bind 'set show-mode-in-prompt on'
  # Set vi-cmd-mode-string
  bind 'set vi-cmd-mode-string "\1\e[2 q\2"'
  # Set vi-ins-mode-string
  bind 'set vi-ins-mode-string "\1\e[3 q\2"'

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
  # bind '"\e[A":history-search-backward'    # uparrow
  # bind '"\e[B":history-search-forward'     # downarrow
fi

