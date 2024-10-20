readonly GIT_BRANCH_CHANGED_SYMBOL='+'
readonly GIT_NEED_PUSH_SYMBOL='↑'
readonly GIT_NEED_PULL_SYMBOL='↓'
readonly GRAY="240"
readonly BLUE="33"
readonly HOME_ICON=" "
readonly SLASH=""
readonly TMUX_ICON=" "

function tmuxinfo(){
	local TS_COUNT="$(tmux ls 2> /dev/null | wc -l)"
  if [ "$PROMPT_STYLE" = "plain" ]
  then
    if [ -n "$TMUX" ]; then
      echo "%F{yellow}%BT%b%f"
    else
      if [ "$TS_COUNT" -gt "0" ]; then
        echo "%F{yellow}%B${TS_COUNT}T%b%f"
      fi
    fi
  else
    if [ -z "$TMUX" ]; then
      if [ "$TS_COUNT" -gt "0" ]; then
        SESSION_COUNT=""
        if [ "$TS_COUNT" -gt "1" ]; then
          SESSION_COUNT="[$TS_COUNT]"
        fi
        echo "%F{yellow}%B$SESSION_COUNT %b%f"
      fi
    fi
  fi
}

function pathinfo() {
  local CHAR_CNT=8
  local COLS="$(tput cols)"
  if [ "$COLS" -lt "80" ]; then
    CHAR_CNT=2
  elif [ "$COLS" -lt "120" ]; then
    CHAR_CNT=3
  fi

  local HOME_SYM=" ~"
  if [ "$PROMPT_STYLE" = "fancy" ]; then
    HOME_SYM=" "
  fi
  local HOME_PATH="$(realpath ~)"
  local PWD_FULL="$(/usr/bin/pwd)"
  if [ "$HOME_PATH" = "$PWD_FULL" ]; then
    echo "$HOME_SYM"
    return
  fi

  local PWD_PATH="$(echo "$PWD_FULL" | sed 's|^\(.*\)/.*|\1|')"
  local PWD_NAME="$(echo "$PWD_FULL" | sed 's|^.*/||')"
  local PATH_NEW="${PWD_PATH/$HOME_PATH/$HOME_SYM}"
  local FINAL_PATH="$(echo "$PATH_NEW" | tr '/' '\n' | sed "s|\(.\{$CHAR_CNT\}\).*|\1|" | paste -sd '/')/$PWD_NAME"

  echo "$FINAL_PATH"
}

function gitinfo() {
	[ -x "$(which git)" ] || return    # git not found

	local repo_exists=$(git rev-parse --is-inside-work-tree 2> /dev/null)
	[[ "$repo_exists" == "true" ]] || return

	# get current branch name or short SHA1 hash for detached head
	local checked_out
	local git_checkout_symbol
	local current_branch=$(git branch --show-current 2> /dev/null)
	local current_tag=$(git tag --points-at=HEAD 2>/dev/null | tail -n1 )
	local current_commit=$(git rev-parse --short HEAD 2>/dev/null)

	[ -n $current_branch ] && {
		checked_out=$current_branch
		git_checkout_symbol='󰊢 '
	}
	[ -n $current_tag ] && [ -z $current_branch ] && {
		checked_out=$current_tag
		git_checkout_symbol='󰓻 '
	}
	[ -n $current_commit ] &&  [ -z $current_branch ] && [ -z $current_tag ] && {
		checked_out=$current_commit
		git_checkout_symbol=' '
	}

	local git_status=$(git status --porcelain | wc -l)
	local marks
  if [ "$PROMPT_STYLE" = "plain" ]
  then
    [ "$git_status" -gt "0" ] && marks+=" $git_status$GIT_BRANCH_CHANGED_SYMBOL"
    echo " %F{yellow}$checked_out$marks%f"
    return
  fi

	# how many commits local branch is ahead/behind of remote?
	local stat="$(git status --porcelain --branch | grep '^##' | grep -o '.\+$')"
	local aheadN="$(echo $stat | grep -o 'ahead [0-9]\+' | grep -o '[0-9]\+')"
	local behindN="$(echo $stat | grep -o 'behind [0-9]\+' | grep -o '[0-9]\+')"
	[ "$git_status" -gt "0" ] && marks+=" $git_status$GIT_BRANCH_CHANGED_SYMBOL"
	[ -n "$aheadN" ] && marks+=" $aheadN$GIT_NEED_PUSH_SYMBOL"
	[ -n "$behindN" ] && marks+=" $behindN$GIT_NEED_PULL_SYMBOL"

	echo "%K{$GRAY}%F{$BLUE}%f%F{yellow}%B$git_checkout_symbol$checked_out$marks%b%f%k%K{$BLUE}%F{$GRAY}%f%k"
}

prompt() {
	# Check the exit code of the previous command and display different
	# colors in the prompt accordingly. 
	local CODE=$?
	local EXIT_CODE=$([ "$CODE" -gt "0" ] && echo $CODE)
	local JOBS="$(jobs | wc -l)"
	local RP=""
	local P=""

	if [ -z $EXIT_CODE ]; then
		local EXIT_COLOR="green"
		local EXIT_ICON=" "
		RP+="%F{$EXIT_COLOR}%B$EXIT_ICON%b%f"
	else
		local EXIT_COLOR="red"
		local EXIT_ICON=" "
		RP+="%F{$EXIT_COLOR}%B[$EXIT_CODE] $EXIT_ICON%b%f"
	fi

  local PATH_INFO=$(pathinfo)
  local TMUX_INFO=$(tmuxinfo)
  local GIT_INFO=$(gitinfo)
  local TMUX_SYMBOL=""

  if [ "$PROMPT_STYLE" = "plain" ]
  then
    RP=$TMUX_INFO

    if [ "$JOBS" -gt "0" ]; then
      RP+="%F{cyan}%B $JOBS&%b%f"
    fi

    P+="%F{cyan}$PATH_INFO%f"
    P+="$GIT_INFO %F{$EXIT_COLOR}$%f "
    PROMPT=$P
    RPROMPT=$RP
    return
  fi

  RP+=$TMUX_INFO
	if [ -n "$TMUX" ]; then TMUX_SYMBOL="$TMUX_ICON";	fi

	if [ "$JOBS" -gt "0" ]; then
		RP+="%F{cyan}%B %b%f"
	fi

	P+="%F{$BLUE}%f%F{white}%K{$BLUE}%B$TMUX_SYMBOL$PATH_INFO%b%k%f"
	P+="$GIT_INFO"
	P+="%F{$BLUE} %f"
	PROMPT=$P
	RPROMPT=$RP
}

function zle-keymap-select zle-line-init zle-line-finish {
  case $KEYMAP in
      vicmd)      print -n '\033[2 q';; # block cursor
      viins|main) print -n '\033[3 q';; # underscore cursor
  esac
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

precmd() {
	prompt
}

zle_highlight=('region:bg=24,fg=254')
export PROMPT_EOL_MARK='' # fix for random % sign before prompt

