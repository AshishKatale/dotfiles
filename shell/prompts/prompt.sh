#!/usr/bin/env bash

__powerline() {

    # Unicode symbols
    readonly PS_SYMBOL_DARWIN=''
    readonly PS_SYMBOL_LINUX=''
    readonly PS_SYMBOL_OTHER='%'
    readonly GIT_BRANCH_CHANGED_SYMBOL='+'
    readonly GIT_NEED_PUSH_SYMBOL='󰜷'
    readonly GIT_NEED_PULL_SYMBOL='󰜮'

    readonly FG_BLACK="\[$(tput setaf 0)\]"
    readonly FG_RED="\[$(tput setaf 1)\]"
    readonly FG_GREEN="\[$(tput setaf 2)\]"
    readonly FG_YELLOW="\[$(tput setaf 3)\]"
    readonly FG_BLUE="\[$(tput setaf 4)\]"
    readonly FG_MAGENTA="\[$(tput setaf 5)\]"
    readonly FG_CYAN="\[$(tput setaf 6)\]"
    readonly FG_WHITE="\[$(tput setaf 7)\]"
    readonly FG_GRAY="\[$(tput setaf 8)\]"
    readonly FG_ORANGE="\[$(tput setaf 9)\]"
    readonly FG_BRIGHTGREEN="\[$(tput setaf 10)\]"
    readonly FG_BRIGHTYELLOW="\[$(tput setaf 11)\]"
    readonly FG_BRIGHTBLUE="\[$(tput setaf 12)\]"
    readonly FG_BRIGHTMAGENTA="\[$(tput setaf 13)\]"
    readonly FG_BRIGHTCYAN="\[$(tput setaf 14)\]"
    readonly FG_BRIGHTWHITE="\[$(tput setaf 15)\]"

    readonly BG_BLACK="\[$(tput setab 0)\]"
    readonly BG_RED="\[$(tput setab 1)\]"
    readonly BG_GREEN="\[$(tput setab 2)\]"
    readonly BG_YELLOW="\[$(tput setab 3)\]"
    readonly BG_BLUE="\[$(tput setab 4)\]"
    readonly BG_MAGENTA="\[$(tput setab 5)\]"
    readonly BG_CYAN="\[$(tput setab 6)\]"
    readonly BG_WHITE="\[$(tput setab 7)\]"
    readonly BG_GRAY="\[$(tput setab 8)\]"
    readonly BG_ORANGE="\[$(tput setab 9)\]"
    readonly BG_BRIGHTGREEN="\[$(tput setab 10)\]"
    readonly BG_BRIGHTYELLOW="\[$(tput setab 11)\]"
    readonly BG_BRIGHTBLUE="\[$(tput setab 12)\]"
    readonly BG_BRIGHTMAGENTA="\[$(tput setab 13)\]"
    readonly BG_BRIGHTCYAN="\[$(tput setab 14)\]"
    readonly BG_BRIGHTWHITE="\[$(tput setab 15)\]"

    readonly DIM="\[$(tput dim)\]"
    readonly REVERSE="\[$(tput rev)\]"
    readonly BOLD="\[$(tput bold)\]"
    readonly RESET="\[$(tput sgr0)\]"
    readonly UNDERLINE_START="\[$(tput smul)\]"
    readonly UNDERLINE_END="\[$(tput rmul)\]"
    readonly STANDOUT_START="\[$(tput smso)\]"
    readonly STANDOUT_END="\[$(tput rmso)\]"

    # rgb(){
    #     if test $4 -eq 02>/dev/null
    #     then
    #       echo "\e[38;2;$1;$2;${3}m"
    #     else
    #       echo "\e[48;2;$1;$2;${3}m"
    #     fi
    # }

    # what OS?
    case "$(uname)" in
        Darwin)
            readonly PS_SYMBOL=$PS_SYMBOL_DARWIN
            ;;
        Linux)
            readonly PS_SYMBOL=$PS_SYMBOL_LINUX
            ;;
        *)
            readonly PS_SYMBOL=$PS_SYMBOL_OTHER
    esac
    

    __git_info() { 
        [ -x "$(which git)" ] || return    # git not found

        local repo_exists=$(git rev-parse --is-inside-work-tree 2> /dev/null)
      	[[ "$repo_exists" == "true" ]] || return

        # get current branch name or short SHA1 hash for detached head
        local branch="$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --always 2>/dev/null)"
        [ -n "$branch" ] || return  # git branch not found

        local marks

        # how many commits local branch is ahead/behind of remote?
        local stat="$(git status --porcelain --branch | grep '^##' | grep -o '\[.\+\]$')"
        local aheadN="$(echo $stat | grep -o 'ahead [0-9]\+' | grep -o '[0-9]\+')"
        local behindN="$(echo $stat | grep -o 'behind [0-9]\+' | grep -o '[0-9]\+')"
        [ -n "$aheadN" ] && marks+=" $aheadN$GIT_NEED_PUSH_SYMBOL"
        [ -n "$behindN" ] && marks+=" $behindN$GIT_NEED_PULL_SYMBOL"

				printf "${BG_GRAY}${RESET}${BG_GRAY}${BOLD}${FG_BRIGHTMAGENTA}  ${branch}${marks}${FG_GRAY}"
    }

    ps1() {
        # Check the exit code of the previous command and display different
        # colors in the prompt accordingly. 
        if [ $? -eq 0 ]; then
          local BG_EXIT="$BG_GREEN"
          local FG_EXIT="$FG_GREEN"
        else
          # local FG_EXIT="$FG_RED"
          local BG_EXIT="\e[48;2;255;100;100m"
          local FG_EXIT="\e[38;2;255;100;100m"
        fi
				
				local CD=$(echo $(pwd) | sed 's/\/home\/ashish/ /g' | sed 's/\///g')

    		PS1="${BOLD}${FG_WHITE}${BG_BLUE} $CD"
    		PS1+="${RESET}${FG_BLUE}"
    		PS1+="$(__git_info)"
        PS1+="${BG_EXIT}${RESET}"
        PS1+="${BG_EXIT}${PS_SYMBOL}${RESET}${FG_EXIT}${RESET} "
    }

    PROMPT_COMMAND=ps1
}

__powerline
unset __powerline

