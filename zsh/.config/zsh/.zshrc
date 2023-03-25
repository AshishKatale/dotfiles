TERM=alacritty
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

ZSH_AUTOSUGGEST_STRATEGY=completion

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)		     # Include hidden files.

bindkey '^I' menu-complete       # Tab key
bindkey '^[[Z' reverse-menu-complete  # Shift Tab key (may vary depending on terminal)

bindkey -M vicmd 'j' undefined-key
bindkey -M vicmd 'k' undefined-key

bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins 'kj' vi-cmd-mode
bindkey -M viins '^w' backward-kill-word
bindkey -M viins '^k' kill-line
bindkey -M viins '^u' backward-kill-line
bindkey -M viins '^a' beginning-of-line
bindkey -M viins '^e' end-of-line
bindkey -M viins '^h' backward-char 
bindkey -M viins '^l' forward-char 
bindkey -M viins '^[w' emacs-forward-word
bindkey -M viins '^[b' emacs-backward-word

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

bindkey -v '^?' backward-delete-char
bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search
bindkey '^ ' expand-or-complete

source $ZDOTDIR/scripts/aliases.zsh 
source $ZDOTDIR/scripts/prompt.zsh 
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

