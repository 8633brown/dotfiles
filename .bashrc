# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]$'
#    ┏    ┗
#    ┌    └

# Append our default paths
appendpath () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}
appendpath ${HOME}/.bin
appendpath ${HOME}/.config/composer/vendor/bin
unset -f appendpath

export XDG_CONFIG_HOME=${HOME}/.config
export XDG_CACHE_HOME=${HOME}/.cache
export XDG_DATA_HOME=${HOME}/.local/share
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export VIMINIT=":source $XDG_CONFIG_HOME"/vim/vimrc
eval $(dircolors "$XDG_CONFIG_HOME"/dircolors/colors)

export HISTFILE="$XDG_DATA_HOME"/bash/history
export HISTCONTROL=ignoredups:erasedups
export EDITOR='vim'
export VISUAL='vim'
export GPG_TTY=$(tty)

alias cd='cd -P'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ls='ls -vl --human-readable --group-directories-first --color'
alias enable='systemctl enable --now'
alias disable='systemctl disable --now'
alias status='systemctl status'
alias ccat='pygmentize -g'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

BOLD="$(tput bold)"
DIM="$(tput dim)"
WHITE="$(tput setaf 255)"
HLIGHT="$(tput smso)"
RESET="$(tput sgr0)"

LTEXT=""
RTEXT='$(printf '%s%${COLUMNS}s%s' "[\u@\h] [\A] [\w]")'

PROMPT_COMMAND='let DASHCOUNT=${COLUMNS}-${#PWD}-34'
DASHES='$(printf %${DASHCOUNT}s | tr " " "-")'

PS1="\n"
PS1+="\${RESET}┌\${BOLD}[\${PWD}]\${RESET}"     #Current directory
PS1+="${DASHES}"                    #Line of "-"
PS1+="\${BOLD}[\u@\h]\${RESET}"     #Current User@Host
PS1+=" [\t]"                        #Time
PS1+="\n"                           #New Line
PS1+="└> "                         #Prompt Indicator

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi

#currenttime=$(date +%H:%M)
#if [[ "$currenttime" > "06:00" ]] && [[ "$currenttime" < "18:00" ]]; then
#  light
#else
#  dark
#fi
#unset currenttime


#alias light='ln -fs ~/bin/light ~/.currenttheme; ~/.currenttheme'
#alias dark='ln -fs ~/bin/dark ~/.currenttheme; ~/.currenttheme'
#~/.currenttheme
