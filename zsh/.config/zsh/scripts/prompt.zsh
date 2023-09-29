readonly GIT_BRANCH_CHANGED_SYMBOL='+'
readonly GIT_NEED_PUSH_SYMBOL='↑'
readonly GIT_NEED_PULL_SYMBOL='↓'
readonly GRAY="240"
readonly BLUE="33"

function tmuxinfo(){
	local TS_COUNT="$(tmux ls 2> /dev/null | wc -l)"
  if [ "$PROMPT_STYLE" = "plain" ]
  then
    if [ -n "$TMUX" ]; then
      echo "%F{yellow}%BT%b%f"
    else
      if [ $TS_COUNT -gt 0 ]; then
        echo "%F{yellow}%B${TS_COUNT}T%b%f"
      fi
    fi
  else
    if [ -z "$TMUX" ]; then
      if [ $TS_COUNT -gt 0 ]; then
        SESSION_COUNT=""
        if [ $TS_COUNT -gt 1 ]; then
          SESSION_COUNT="[$TS_COUNT]"
        fi
        echo "%F{yellow}%B$SESSION_COUNT %b%f"
      fi
    fi
  fi
}

function pathinfo() {
  local HOMEPATH_FULL="$(realpath ~)"
  local HOMEPATH_SHORT3=$(realpath ~ \
    | awk '{ split($0,arr,"/") } END{ for(i in arr){ print substr(arr[i],0,3) } }' \
    | tr '\n' '/'
  )
  local HOMEPATH_SHORT1=$(realpath ~ \
    | awk '{ split($0,arr,"/") } END{ for(i in arr){ print substr(arr[i],0,1) } }' \
    | tr '\n' '/'
  )
  local COLS="$(tput cols)"
  local CD="${PWD##*/}"
  local HD="${$(realpath ~)##*/}"

  if [ "$PROMPT_STYLE" = "plain" ]
  then
    if [ "$CD" = "$HD" ]; then CD="~/"; fi
    if [ $COLS -lt 80 ]; then
      echo "$(pwd | awk '{ split($0,arr,"/") } END{ for(i in arr){ print substr(arr[i],0,1) } }' | tr '\n' '/')" \
        | sed "s|$HOMEPATH_SHORT1|~/|g" \
        | sed "s|\(.*\).\/\$|\1$CD|"
    elif [ $COLS -lt 120 ]; then
      echo "$(pwd | awk '{ split($0,arr,"/") } END{ for(i in arr){ print substr(arr[i],0,3) } }' | tr '\n' '/')" \
        | sed "s|$HOMEPATH_SHORT3|~/|g" \
        | sed "s|\(.*\)...\/\$|\1$CD|"
    else
      echo "$(pwd | sed "s|$HOMEPATH_FULL|~|g")"
    fi
  else
    if [ $COLS -lt 80 ]; then
      echo "$(pwd | awk '{ split($0,arr,"/") } END{ for(i in arr){ print substr(arr[i],0,1) } }' | tr '\n' '/')" \
        | sed "s|$HOMEPATH_SHORT1| |g" \
        | sed "s|\(.*\).\/\$|\1$CD|" \
        | sed 's|\/||g'
    elif [ $COLS -lt 120 ]; then
      echo "$(pwd | awk '{ split($0,arr,"/") } END{ for(i in arr){ print substr(arr[i],0,3) } }' | tr '\n' '/')" \
        | sed "s|$HOMEPATH_SHORT3| |g" \
        | sed "s|\(.*\)...\/\$|\1$CD|" \
        | sed 's|\/||g'
    else
      echo "$(pwd | sed "s|$HOMEPATH_FULL| |g" | sed 's/\///g')"
    fi
  fi
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

	echo "%K{$GRAY}%F{$BLUE}%f%F{yellow}%B$git_checkout_symbol$checked_out$marks%b%f%k%K{$BLUE}%F{$GRAY}%f%k"
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

    if [ $JOBS -gt 0 ]; then
      RP+="%F{cyan}%B $JOBS&%b%f"
    fi

    P+="%F{cyan}$PATH_INFO%f"
    P+="$GIT_INFO %F{$EXIT_COLOR}$%f "
    PROMPT=$P
    RPROMPT=$RP
    return
  fi

  RP+=$TMUX_INFO
	if [ -n "$TMUX" ]; then TMUX_SYMBOL=" ";	fi

	if [ $JOBS -gt 0 ]; then
		RP+="%F{cyan}%B %b%f"
	fi

	P+="%F{$BLUE}%f%F{white}%K{$BLUE}%B$TMUX_SYMBOL$PATH_INFO%b%k%f"
	P+="$GIT_INFO"
	P+="%F{$BLUE} %f"
	PROMPT=$P
	RPROMPT=$RP
}

function zle-line-init zle-keymap-select {
	local MODE_COLOR=$BLUE
	local MODE="${${KEYMAP/vicmd/NORMAL}/(main|viins)/INSERT}"
	local VIMODE="%F{$MODE_COLOR}%f%K{$MODE_COLOR}%F{$GRAY}%f%k%K{$GRAY}$MODE%k%F{$GRAY}%K{$MODE_COLOR}%k%f%F{$MODE_COLOR}%f"
  if [[ "$PROMPT_STYLE" = "plain" ]]
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
      RPROMPT=$(echo $RPROMPT | sed "s/%F{$BLUE}.*.*%f//g")
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

