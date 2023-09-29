#!/usr/bin/env bash

__powerline() {

    BG () {
      echo "\[$(tput setab $1)\]"
    }
    FG () {
      echo "\[$(tput setaf $1)\]"
    }

    readonly GIT_BRANCH_CHANGED_SYMBOL='+'
    readonly GIT_NEED_PUSH_SYMBOL='↑'
    readonly GIT_NEED_PULL_SYMBOL='↓'

    readonly FG_GRAY=$(FG 240)
    readonly FG_BLUE=$(FG 33)
    readonly FG_YELLOW=$(FG 3)
    readonly FG_GREEN=$(FG 2)
    readonly FG_WHITE=$(FG 7)
    readonly FG_BRIGHTYELLOW=$(FG 11)

    readonly BG_GRAY=$(BG 240)
    readonly BG_BLUE=$(BG 33)
    readonly BG_YELLOW=$(BG 3)
    readonly BG_GREEN=$(BG 2)
    readonly BG_BRIGHTYELLOW=$(BG 11)

    readonly DIM="\[$(tput dim)\]"
    readonly REVERSE="\[$(tput rev)\]"
    readonly BOLD="\[$(tput bold)\]"
    readonly RESET="\[$(tput sgr0)\]"
    readonly UNDERLINE_START="\[$(tput smul)\]"
    readonly UNDERLINE_END="\[$(tput rmul)\]"
    readonly STANDOUT_START="\[$(tput smso)\]"
    readonly STANDOUT_END="\[$(tput rmso)\]"

    __git_info() { 
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
          printf " $FG_BRIGHTYELLOW$checked_out$marks"
          return
        fi

        # how many commits local branch is ahead/behind of remote?
        local stat="$(git status --porcelain --branch | grep '^##' | grep -o '.\+$')"
        local aheadN="$(echo $stat | grep -o 'ahead [0-9]\+' | grep -o '[0-9]\+')"
        local behindN="$(echo $stat | grep -o 'behind [0-9]\+' | grep -o '[0-9]\+')"
        [ -n "$aheadN" ] && marks+=" $aheadN$GIT_NEED_PUSH_SYMBOL"
        [ "$git_status" -gt 0 ] && marks+=" $git_status$GIT_BRANCH_CHANGED_SYMBOL"
        [ -n "$behindN" ] && marks+=" $behindN$GIT_NEED_PULL_SYMBOL"

				printf "$BG_GRAY$FG_BLUE$RESET$BG_GRAY$BOLD$FG_YELLOW$git_checkout_symbol$checked_out$marks$FG_GRAY"
    }

    __path_info() {
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
        local HD=$USER

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

    ps1() {
        # Check the exit code of the previous command and display different
        # colors in the prompt accordingly. 
        if [ $? -eq 0 ]; then
          local BG_EXIT="$BG_GREEN"
          local FG_EXIT="$FG_GREEN"
        else
          local BG_EXIT="\e[48;2;255;100;100m"
          local FG_EXIT="\e[38;2;255;100;100m"
        fi
				
        if [ "$PROMPT_STYLE" = "plain" ]; then
          PS1="$BOLD$FG_BLUE$(__path_info)"
          PS1+="$RESET$FG_BLUE"
          PS1+="$(__git_info)"
          PS1+="$FG_EXIT$BOLD \$$RESET "
          return
        fi

				local CD=$(echo $(pwd) | sed "s|/home/$USER| |g" | sed 's/\///g')
        local TMUX_SYMBOL=""
        if [ -n "$TMUX" ]; then TMUX_SYMBOL=" ";	fi

        PS1="$BOLD$FG_BLUE$FG_WHITE$BG_BLUE$TMUX_SYMBOL$(__path_info)"
    		PS1+="$RESET$FG_BLUE"
    		PS1+="$(__git_info)"
        PS1+="$BG_EXIT$RESET"
        PS1+="$BG_EXIT$RESET$FG_EXIT $RESET"
    }

    PROMPT_COMMAND=ps1
}

__powerline
unset __powerline

