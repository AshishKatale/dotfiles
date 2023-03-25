#!/usr/bin/env bash 

__setprompt(){

	readonly DIM="\[$(tput dim)\]"
	readonly REVERSE="\[$(tput rev)\]"
	readonly RESET="\[$(tput sgr0)\]"
	readonly BOLD="\[$(tput bold)\]"

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

	readonly FG_COLOR1="\[\e[38;5;250m\]"

	gitInfo(){
        local branch="$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --always 2>/dev/null)"
	}

	ps1(){
		if [ $? -eq 0 ]
		then
			local EXIT_CODE=$FG_BRIGHTYELLOW
		else
			local EXIT_CODE=$FG_ORANGE
		fi
	
		PS1="${BOLD}${FG_BRIGHTGREEN}\u@\h${FG_BRIGHTWHITE}:${FG_BLUE}\w ${FG_MAGENTA}$(git branch --show-current 2>/dev/null)\n${RESET}${FG_BRIGHTCYAN}\T \D{%p} ${BOLD}${EXIT_CODE}\$ ${RESET}${FG_BRIGHTWHITE}"

	}

	PROMPT_COMMAND=ps1

}

__setprompt
unset __setprompt

