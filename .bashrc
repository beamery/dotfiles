# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# PERSONAL SETTINGS
export TERM=xterm-256color

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

export PATH=${PATH}:$HOME/.local/bin:$HOME/scripts:/usr/local/bin
# Add ~/opt and ~/bin to our path
#export PATH=$HOME/opt:$HOME/bin:$PATH

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.


if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Personal
if hash nvim 2>/dev/null; then
  alias vim='nvim'
fi

function kubectl_pod() {
  kubectl get pods -n $2 | awk -v regex="$1" '$0~regex { print $1 }'
}

function kubectl_log() {
  pods=$(kubectl_pod $1 $2)
  joined_pods=`for pod in $pods; do printf "kubectl logs -f -n $2 $pod & "; done`
  log_cmd=${joined_pods}
  trap 'kill $(jobs -p)' SIGINT
  eval "{ " $log_cmd "wait; }"
}

export P4DIFF='vimdiff -f'
export P4MERGE='vimmerge'

#export FZF_DEFAULT_COMMAND='find . -maxdepth 1'
export FZF_DEFAULT_COMMAND='find .'
#[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Source ~/.bashrc whenever it changes
function source_bashrc_if_changed() {
    BASHRC_PATH=$(readlink -f ~/.bashrc)
    NEW_BASHRC_CHANGETIME=$(stat -c %z $BASHRC_PATH)
    if [ "$NEW_BASHRC_CHANGETIME" != "$BASHRC_CHANGETIME" ]; then
        if [ -n "$BASHRC_CHANGETIME" ]; then
            echo "$BASHRC_PATH changed at $NEW_BASHRC_CHANGETIME -- sourcing"
            source $BASHRC_PATH
        fi
        BASHRC_CHANGETIME=$NEW_BASHRC_CHANGETIME
    fi
}
export PROMPT_COMMAND="source_bashrc_if_changed"

## Set the Hi status to be displayed as part of the prompt. #!>>HI<<!#
#PS1="\[\${__hi_prompt_color}\]\${__hi_prompt_text}\[${__hi_NOCOLOR}\]${PS1}" #!>>HI<<!#
## Set the default values for the text of the hi prompt. Change these if you like. #!>>HI<<!#
#__hi_on_prompt="[hi on] " #!>>HI<<!#
#__hi_off_prompt="[hi off]" #!>>HI<<!#


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
