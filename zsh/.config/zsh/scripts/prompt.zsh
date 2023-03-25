readonly GIT_BRANCH_CHANGED_SYMBOL='+'
readonly GIT_NEED_PUSH_SYMBOL='󰜷'
readonly GIT_NEED_PULL_SYMBOL='󰜮'
readonly GRAY="#555555"
readonly BLUE="#0A7BCB"

function gitinfo() {
	[ -x "$(which git)" ] || return    # git not found

	local repo_exists=$(git rev-parse --is-inside-work-tree 2> /dev/null)
	[[ "$repo_exists" == "true" ]] || return

	# get current branch name or short SHA1 hash for detached head
	local branch="$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --always 2>/dev/null)"
	[ -n "$branch" ] || return  # git branch not found

	local git_status=$(git status --porcelain | wc -l)

	local marks

	# how many commits local branch is ahead/behind of remote?
	local stat="$(git status --porcelain --branch | grep '^##' | grep -o '.\+$')"
	local aheadN="$(echo $stat | grep -o 'ahead [0-9]\+' | grep -o '[0-9]\+')"
	local behindN="$(echo $stat | grep -o 'behind [0-9]\+' | grep -o '[0-9]\+')"
	[ "$git_status" -gt 0 ] && marks+=" $git_status$GIT_BRANCH_CHANGED_SYMBOL"
	[ -n "$aheadN" ] && marks+=" $aheadN$GIT_NEED_PUSH_SYMBOL"
	[ -n "$behindN" ] && marks+=" $behindN$GIT_NEED_PULL_SYMBOL"

	echo "%K{$GRAY}%B%F{magenta}󰊢 ${branch}${marks}%F{$GRAY}"
}

prompt() {
	# Check the exit code of the previous command and display different
	# colors in the prompt accordingly. 
	local CODE=$?
	local EXIT_CODE=$([ $CODE -gt 0 ] && echo $CODE)
	local JOBS="$(jobs | wc -l)"
	local RP=""
	local P=""

	if [ $JOBS -gt 0 ]; then
		RP+="%F{$BLUE}%B  %b%f"
	fi

	if [ -z $EXIT_CODE ]; then
		local EXIT_COLOR="green"
		local EXIT_ICON=""
		RP+="%F{$EXIT_COLOR}%B$EXIT_ICON %b%f"
	else
		local EXIT_COLOR="red"
		local EXIT_ICON=""
		RP+="%F{$EXIT_COLOR}%B[$EXIT_CODE] $EXIT_ICON%b%f "
	fi

	local CD=$(echo $PWD | sed "s|/home/$USER| |g" | sed 's/\///g')
	P+="%B%F{white}%K{$BLUE} $CD"
	P+="%b%f%k%F{$BLUE}"
	P+="$(gitinfo)"
	P+="%K{green}%f"
	P+="%k%F{green} %f"
	PROMPT=$P
	RPROMPT=$RP
}

function zle-line-init zle-keymap-select {
	local MODE_COLOR=$BLUE
	local MODE="${${KEYMAP/vicmd/NORMAL}/(main|viins)/INSERT}"
	local VIMODE="%F{$MODE_COLOR}%K{$GRAY} %f%B$MODE%b%F{$MODE_COLOR} %k%f" 
	if [[ $MODE == "NORMAL" ]]; then
		RPROMPT="$RPROMPT$VIMODE"
	else
		RPROMPT=$(echo $RPROMPT | sed "s/.*//g")
	fi
	zle && { zle reset-prompt; zle -R }
}
zle -N zle-line-init
zle -N zle-keymap-select

precmd() {
	prompt
}

