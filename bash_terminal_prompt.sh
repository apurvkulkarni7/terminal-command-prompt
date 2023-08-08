#!/bin/bash

# Resources
# https://stackoverflow.com/questions/44792926/text-doesnt-clear-after-modifying-terminal-prompt

# To do: Misaligned visuals if virtual environment is acivated

txtblk="\[\e[0;30m\]" # Black - Regular
txtred="\[\e[0;31m\]" # Red
txtgrn="\[\e[0;32m\]" # Green
txtylw="\[\e[0;33m\]" # Yellow
txtblu="\[\e[0;34m\]" # Blue
txtpur="\[\e[0;35m\]" # Purple
txtcyn="\[\e[0;36m\]" # Cyan
txtwht="\[\e[0;37m\]" # White
bldblk="\[\e[1;30m\]" # Black - Bold
bldred="\[\e[1;31m\]" # Red
bldgrn="\[\e[1;32m\]" # Green
bldylw="\[\e[1;33m\]" # Yellow
bldblu="\[\e[1;34m\]" # Blue
bldpur="\[\e[1;35m\]" # Purple
bldcyn="\[\e[1;36m\]" # Cyan
bldwht="\[\e[1;37m\]" # White
unkblk="\[\e[4;30m\]" # Black - Underline
undred="\[\e[4;31m\]" # Red
undgrn="\[\e[4;32m\]" # Green
undylw="\[\e[4;33m\]" # Yellow
undblu="\[\e[4;34m\]" # Blue
undpur="\[\e[4;35m\]" # Purple
undcyn="\[\e[4;36m\]" # Cyan
undwht="\[\e[4;37m\]" # White
bakblk="\[\e[40m\]"   # Black - Background
bakred="\[\e[41m\]"   # Red
bakgrn="\[\e[42m\]"   # Green
bakylw="\[\e[43m\]"   # Yellow
bakblu="\[\e[44m\]"   # Blue
bakpur="\[\e[45m\]"   # Purple
bakcyn="\[\e[46m\]"   # Cyan
bakwht="\[\e[47m\]"   # White
txtrst="\[\e[0m\]"    # Text Reset
#color_none='\[\e[0m\]'

darkgrey="\[\e[38;5;237m\]"
darkgreybold="\[\e[1;38;5;239m\]"

line_col=$darkgreybold

parse_git_branch() {
	git_branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/")
	
	# Formatting the cli visual for git
	#txtred="\[\e[0;31m\]"
	#darkgreybold="\[\e[1;38;5;239m\]"

	if [[ "$git_branch" == "" ]]
	then
		printf ""
        GIT_PROMPT=""
	else
		#printf "${darkgreybold}──[${txtred}${git_branch}${darkgreybold}]"
		printf "${git_branch}"
        #GIT_PROMPT="${darkgreybold}──[${txtred}${git_branch}${darkgreybold}]${color_none}"
        #echo -e "\e${darkgreybold}\e──[\e${txtred}${git_branch}"
	fi
}

# Determine active Python virtualenv details.
set_virtualenv() {
    VIRTUAL_ENV="${VIRTUAL_ENV:-""}"
  if [[ "$VIRTUAL_ENV" == "" ]] ; then
    #PYTHON_VIRTUALENV=""
    #echo here
    #PYTHON_VENV_PROMPT=""
    printf ""
  else
    #PYTHON_VIRTUALENV="${darkgreybold}──[${txtred}`basename "$VIRTUAL_ENV"`${darkgreybold}]${color_none}"
    python_venv=$(basename "$VIRTUAL_ENV")
    printf "${python_venv}"
    #printf "$darkgreybold"
    #PYTHON_VENV_PROMPT="${darkgreybold}──[${txtpur}${python_venv}${darkgreybold}]${color_none}"
  fi
}

set_time_date() {
    #printf "${bldylw}\t - \d" # Time and date
    DATE_PROMPT="${bldylw}\t${line_col}"
}

set_user() {
    USER_PROMPT="${bldgrn}\u@\h${line_col}"
}

set_location() {
    LOCATION_PROMPT="${bldblu}\w${line_col}"
}

#parse_git_branch
#set_virtualenv
set_time_date
set_user
set_location

#left="${line_col}┌─[${bldylw}\t - \d${line_col}]──[${bldgrn}\u@\h${line_col}]──[${bldblu}\w${line_col}]${GIT_PROMPT}${PYTHON_VENV_PROMPT}${color_none}"
#left="${line_col}┌─[${bldylw}\t - \d${line_col}]──[${bldgrn}\u@\h${line_col}]──[${bldblu}\w${line_col}]\$(parse_git_branch)\$(set_virtualenv)" #${color_none}"

#left="${line_col}┌─[${DATE_PROMPT}]──[${bldgrn}\u@\h${line_col}]──[${bldblu}\w${line_col}]\$(parse_git_branch)\$(set_virtualenv)"
#left="${line_col}┌─[${DATE_PROMPT}]──[${USER_PROMPT}]──[${LOCATION_PROMPT}]\$(parse_git_branch)${darkgreybold}──[${txtpur}\$(set_virtualenv)${darkgreybold}]"
left="${line_col}┌─[${DATE_PROMPT}]──[${USER_PROMPT}]──[${LOCATION_PROMPT}]${darkgreybold}──[${txtred}\$(parse_git_branch)${darkgreybold}]──[${txtpur}\$(set_virtualenv)${darkgreybold}]"

#left="${line_col}┌─[${bldgrn}\u@\h${txtwht}]──[${bldblu}\w${txtwht}]──[${bldred}\$(parse_git_branch)${txtwht}]"
#left="${line_col}┌─[${bldgrn}\u@\h${txtwht}]──[${bldblu}\w${txtwht}]──${bldred}\$(parse_git_branch)"

#line="`printf -vch "%${COLUMNS}s" ""; printf "%s" "${ch// /─}"`"

#right="[${bldylw}\t - \d${line_col}]"

#down="${line_col}└─[${bldpur}\$${txtwht}]› ${txtrst}"
down="${line_col}└─[${bldpur}\$${line_col}] "

#export PS1="${left}${line_col}\${line:\${#left}+\${#right}-\$compensation}${right}\n${down}"
#export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
#export PS1="${left}${line_col}\${pars_col}${right}\n${down}"
#export PS1="${line_col}┌─[${bldgrn}\u@\h${txtwht}]──[${bldblu}\w${txtwht}]${bldred}\$(parse_git_branch)\n${txtwht}└─[${bldpur}\$${txtwht}]› ${txtrst}"
export PS1="${left}\n${down}${txtrst}"

###############################################################################
# Method 2
#function prompt_right() {
#	#echo -e "\033[0;36m$(echo ${RANDOM})\033[0m"
#	echo "[${bldylw}\t - \d${line_col}]"
#  }
#
#function prompt_left() {
#	#echo -e "\033[0;35m${RANDOM}\033[0m"
#	echo $left
#  }
#
#function prompt() {
#	    compensate=0
#	        PS1=$(printf "%*s\r%s\n\$ " "$(($(tput cols)+${compensate}))" "$(prompt_right)" "$(prompt_left)")
#	}
#PROMPT_COMMAND=prompt


export VIRTUAL_ENV_DISABLE_PROMPT=1
