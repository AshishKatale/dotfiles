readonly GIT_BRANCH_CHANGED_SYMBOL='+'
readonly GIT_NEED_PUSH_SYMBOL='↑'
readonly GIT_NEED_PULL_SYMBOL='↓'
readonly GRAY="#555555"
readonly BLUE="#0A7BCB"

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
		git_checkout_symbol='󰊢'
	}
	[ -n $current_tag ] && [ -z $current_branch ] && {
		checked_out=$current_tag
		git_checkout_symbol='󰓻'
	}
	[ -n $current_commit ] &&  [ -z $current_branch ] && [ -z $current_tag ] && {
		checked_out=$current_commit
		git_checkout_symbol=''
	}

	local git_status=$(git status --porcelain | wc -l)
	local marks
  if [ "$ZPROMPT_STYLE" = "plain" ]
  then
    [ "$git_status" -gt 0 ] && marks+=" $git_status$GIT_BRANCH_CHANGED_SYMBOL"
    echo " %F{yellow}$checked_out$marks%f"
    return
  fi

	# how many commits local branch is ahead/behind of remote?
	local stat="$(git status --porcelain --branch | grep '^##' | grep -o '.\+$')"
	local aheadN="$(echo $stat | grep -o 'ahead [0-9]\+' | grep -o '[0-9]\+')"
	local behindN="$(echo $stat | grep -o 'behind [0-9]\+' | grep -o '[0-9]\+')"
	[ "$git_status" -gt 0 ] && marks+=" $git_status$GIT_BRANCH_CHANGED_SYMBOL"
	[ -n "$aheadN" ] && marks+=" $aheadN$GIT_NEED_PUSH_SYMBOL"
	[ -n "$behindN" ] && marks+=" $behindN$GIT_NEED_PULL_SYMBOL"

	echo "%K{$GRAY}%B%F{yellow}$git_checkout_symbol $checked_out$marks%F{$GRAY}"
}

prompt() {
	# Check the exit code of the previous command and display different
	# colors in the prompt accordingly. 
	local CODE=$?
	local EXIT_CODE=$([ $CODE -gt 0 ] && echo $CODE)
	local JOBS="$(jobs | wc -l)"
	local RP=""
	local P=""

	if [ -z $EXIT_CODE ]; then
		local EXIT_COLOR="green"
		local EXIT_ICON=""
		RP+="%F{$EXIT_COLOR}%B$EXIT_ICON %b%f"
	else
		local EXIT_COLOR="red"
		local EXIT_ICON=""
		RP+="%F{$EXIT_COLOR}%B[$EXIT_CODE] $EXIT_ICON%b%f "
	fi

  local HOMEPATH="$(realpath ~)"
  local CD=$(echo $PWD | sed "s|$HOMEPATH| |g" | sed 's/\///g')
	local TMX="$(tmux ls 2> /dev/null | wc -l)"
  local TMUX_STR=""

  if [ "$ZPROMPT_STYLE" = "plain" ]
  then
    RP=""
    CD=$PWD
    HOMEPATH_LEN=${#HOMEPATH}

    if [ ${#PWD} -gt $HOMEPATH_LEN ]; then
      CD=$(echo $PWD | sed "s|$HOMEPATH|~|g")
    fi

    if [ -n "$TMUX" ]; then
      RP+="%F{yellow}%BT%b%f"
    else
      if [ $TMX -gt 0 ]; then
        RP+="%F{yellow}%B${TMX}T%b%f"
      fi
    fi

    if [ $JOBS -gt 0 ]; then
      RP+="%F{cyan}%B $JOBS&%b%f"
    fi

    P+="%F{cyan}$CD%f"
    P+="$(gitinfo) %F{$EXIT_COLOR}$%f "
    PROMPT=$P
    RPROMPT=$RP
    return
  fi

	if [ -n "$TMUX" ]; then
	  TMUX_STR=" "	
  else
    if [ $TMX -gt 0 ]; then
      RP+="%F{yellow}%B %b%f"
    fi
	fi

	if [ $JOBS -gt 0 ]; then
		RP+="%F{$BLUE}%B  %b%f"
	fi

	P+="%B%F{white}%K{$BLUE} $TMUX_STR$CD"
	P+="%b%f%k%F{$BLUE}"
	P+="$(gitinfo)"
	P+="%K{$BLUE}%f"
	P+="%k%F{$BLUE} %f"
	PROMPT=$P
	RPROMPT=$RP
}

function zle-line-init zle-keymap-select {
	local MODE_COLOR=$BLUE
	local MODE="${${KEYMAP/vicmd/NORMAL}/(main|viins)/INSERT}"
	local VIMODE="%F{$MODE_COLOR}%K{$GRAY}%f$MODE%F{$MODE_COLOR}%k%f" 
  if [[ "$ZPROMPT_STYLE" = "plain" ]]
  then
    if [[ $MODE == "NORMAL" ]]; then
      RPROMPT="$RPROMPT%F{green} $MODE %f"
    else
      RPROMPT=$(echo $RPROMPT | sed "s/\sNORMAL\s//g")
    fi
  else
    if [[ $MODE == "NORMAL" ]]; then
      RPROMPT="$RPROMPT$VIMODE"
    else
      RPROMPT=$(echo $RPROMPT | sed "s/.*//g")
    fi
  fi
	zle && { zle reset-prompt; zle -R }
}
zle -N zle-line-init
zle -N zle-keymap-select

precmd() {
	prompt
}

export PROMPT_EOL_MARK='' # fix for random % sign before prompt

