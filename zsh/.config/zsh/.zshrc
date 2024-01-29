TERM=xterm-256color
EDITOR=vim
HISTFILE="$ZDOTDIR/.zsh_history"
SAVEHIST=5000
HISTSIZE=1000

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt nocaseglob 		           # Case insensitive completion

ZSH_AUTOSUGGEST_STRATEGY=(completion history)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#787878"
fpath=($ZDOTDIR/plugins/zsh-completions/src $fpath)

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)		     # Include hidden files.

bindkey '^I' menu-complete       # Tab key
bindkey -M menuselect '^[[Z' reverse-menu-complete

bindkey -M vicmd 'j' undefined-key
bindkey -M vicmd 'k' undefined-key

bindkey -M viins '^j' undefined-key
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins 'kj' vi-cmd-mode
bindkey -M viins '^w' backward-kill-word
bindkey -M viins '^k' kill-line
bindkey -M viins '^u' backward-kill-line
bindkey -M viins '^a' beginning-of-line
bindkey -M viins '^e' end-of-line
bindkey -M viins '^l' clear-screen
bindkey -M viins '^[w' emacs-forward-word
bindkey -M viins '^[b' emacs-backward-word
bindkey -s -M visual 'i' '^[' # exit visual mode with i 
bindkey -s -M viins '^b' 'tmux-sessionizer^M'

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

bindkey -v '^?' backward-delete-char
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search
bindkey '^ ' autosuggest-toggle

source $ZDOTDIR/scripts/aliases.zsh 
source $ZDOTDIR/scripts/prompt.zsh 
source $ZDOTDIR/scripts/nvm.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# fzf key-bindings
if [ -f $ZDOTDIR/plugins/key-bindings.zsh ]; then
  source $ZDOTDIR/plugins/key-bindings.zsh
  bindkey '^t' undefined-key
  bindkey '^x' fzf-file-widget
  bindkey '^r' fzf-history-widget
fi
