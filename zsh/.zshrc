#                   ZSH configs
#
#                 _____    _     
#                |__  /___| |__  
#                  / // __| '_ \ 
#                 / /_\__ \ | | |
#                /____|___/_| |_|
#

# Shell options
bindkey -e
unsetopt beep
setopt autocd 
setopt promptsubst
setopt extendedglob

# Env variables
export EDITOR=vim
export HISTSIZE=2000
export SAVEHIST=2000
export HISTFILE=~/.zsh_history

# Clean screen
cd ~/
clear

# Prompt
precmd() {
    precmd() {
        echo
    }
}

function gitBranch(){
	return_code=$?
	branch=""
	if git branch &> /dev/null; then
		branch=": %F{yellow}$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')%F{cyan}"
	fi
	echo -en ${branch}
}

if [[ $UID -eq 0 ]]; then
		PROMPT='%B%F{white}%K{cyan}[%T 🎲 %~$(gitBranch)]'$'\n''%B%F{red}%K{red}█%F{white}%n%b%F{red}%K{black}█▓▒░%B%k %F{yellow}#%b%f '
	else
		PROMPT='%B%F{white}%K{cyan}[%T 🎲 %~$(gitBranch)]'$'\n''%B%F{green}%K{green}█%F{white}%n%b%F{green}%K{black}█▓▒░%B%k %F{yellow}$%b%f '
fi
RPROMPT='%(?.%F{green}✔.%F{red}✘)%f'

# Aliases
if [[ -e ~/.aliases ]]; then
	source ~/.aliases
fi

# Completion
autoload -Uz compinit 
compinit

# Custom functions
man() {
	LESS_TERMCAP_md=$'\e[01;33m' \
	LESS_TERMCAP_me=$'\e[0m' \
	LESS_TERMCAP_so=$'\e[01;44;33m' \
	LESS_TERMCAP_se=$'\e[0m' \
	LESS_TERMCAP_us=$'\e[01;34m' \
	LESS_TERMCAP_ue=$'\e[0m' \
	command man "$@"
}
