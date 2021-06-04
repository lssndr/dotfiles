#                  BASH configs                
#                       MM                       
#                   MMMMMMMMMM                   
#               MMMMMMMMMMMMMMMMMM               
#            MMMMMMMMMMMMMMMMMMMMMMMM            
#        MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM        
#       MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM      
#      MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM      
#      MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM....M      
#      MMMMMMMMMMMMMMMMMMMMMMMMMMM........M      
#      MMMMMMMMMMMMMMMMMMMMMM.............M      
#      MMMMMMMMMMMMMMMMMMMM...............M      
#      MMMMMMMMMMMMMMMMMM....XX...........M      
#      MMMMMMMMMMMMMMMMMM...XXXX..........M      
#      MMMMMMMMMMMMMMMMMM...XXX...........M      
#      MMMMMMMMMMMMMMMMMM...XXXX..........M      
#       MMMMMMMMMMMMMMMMM....XXX..........M      
#         MMMMMMMMMMMMMMM...XXX........:         
#             MMMMMMMMMMM..........:             
#                MMMMMMMM.......:                
#                    MMMM...:

# If not running interactively simply return
case $- in
	*i*) ;;
      *) return;;
esac

# Shell options
shopt -s autocd
shopt -s cdspell
shopt -s dirspell
shopt -s direxpand
shopt -s histappend
shopt -s checkwinsize

# Env variables
export EDITOR=vim
export HISTSIZE=2000
export HISTCONTROL=ignoreboth
export FZF_DEFAULT_COMMAND="find -not -path '*/\.git/*'"

# Clean screen
cd ~/
clear

# Prompt
function returnCode() {
	if [ $? -eq 0 ]; then
		echo -en "\e[32m ✔"
	else
		echo -en "\e[31m ✘"
	fi
}

function gitBranch(){
	return_code=$?
	branch=""
	if git branch &> /dev/null; then
		branch=": \e[35m$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')\e[34m"
	fi
	echo -en ${branch}
	exit ${return_code}
}

if [[ $UID -eq 0 ]]; then
		PS1='\[\e[1;34m\][\A 🎲 \W$(gitBranch)]$(returnCode)\n\[\e[1;31m\]\u \[\e[1;33m\]\$\[\e[0m\] '
	else
		PS1='\[\e[1;34m\][\A 🎲 \W$(gitBranch)]$(returnCode)\n\[\e[1;32m\]\u \[\e[1;33m\]\$\[\e[0m\] '
fi
PROMPT_COMMAND="PROMPT_COMMAND=echo"

# Aliases
if [[ -e ~/.aliases ]]; then
	source ~/.aliases
fi

# Completion
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
    	source /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
  		source /etc/bash_completion
	fi
fi

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

