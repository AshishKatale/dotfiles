HISTFILE="$ZDOTDIR/.zsh_history"
SAVEHIST=10000
HISTSIZE=2000

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
setopt nocaseglob                # Case insensitive completion

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#787878"
fpath=($ZDOTDIR/plugins/zsh-completions/src $fpath)

zmodload zsh/complist
_comp_options+=(globdots)     # Include hidden files.
autoload -Uz compinit && compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors 'ma=01;30;44:rs=0:di=01;34:ln=01;36:mh=00:pi=40;
33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;
43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32'

bindkey -M vicmd 'j' undefined-key
bindkey -M vicmd 'k' undefined-key

bindkey -M viins '^j' undefined-key
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins '^w' backward-kill-word
bindkey -M viins '^k' kill-line
bindkey -M viins '^u' backward-kill-line
bindkey -M viins '^a' beginning-of-line
bindkey -M viins '^e' end-of-line
bindkey -M viins '^l' clear-screen
bindkey -M viins '^[w' emacs-forward-word
bindkey -M viins '^[b' emacs-backward-word
bindkey -M viins '	' menu-expand-or-complete # Tab key
bindkey -M viins '^ ' menu-expand-or-complete # C-Space

bindkey -s -M visual 'i' '^[' # exit visual mode with i

# Use vim keys in complete menu:
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^j' vi-down-line-or-history
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^p' vi-up-line-or-history
bindkey -M menuselect '^n' vi-down-line-or-history
bindkey -M menuselect '^[[Z' reverse-menu-complete  # S-Tab key

bindkey -v '^?' backward-delete-char

# Cycle through history based on characters already typed on the line
bindkey -M viins '^p' history-beginning-search-backward
bindkey -M viins '^n' history-beginning-search-forward

bindkey -M viins '^h' autosuggest-toggle
bindkey -M viins '^y' autosuggest-accept

source $ZDOTDIR/scripts/aliases.zsh
source $ZDOTDIR/scripts/prompt.zsh
source $ZDOTDIR/scripts/nvm.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

which lazygit &> /dev/null && bindkey -s -M viins '^g' '^E^U lazygit^M'
[ -e $HOME/bin/tmux-sm ] && bindkey -s -M viins '^b' '^E^U tmux-sm^M'

# fzf key-bindings
hash fzf &> /dev/null && {
  source <(fzf --zsh)
  bindkey '^t' undefined-key # disable default fzf ^t
  bindkey '^x' fzf-cd-widget
  bindkey '^f' fzf-file-widget
  bindkey '^r' fzf-history-widget
}
