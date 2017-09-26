# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Prints last stable build of specified project in TAP
function stable() {
  /google/data/ro/projects/testing/tap/scripts/last_green_cl.par --project=$1
}


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

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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
JARTPS1_THEME=dark source ~/.jartps1.sh
export TERM=screen-256color

# Crow - Android emulator
alias crow=/google/data/ro/teams/mobile_eng_prod/crow/crow.par

# Tab completion for crow
source /google/data/ro/teams/mobile_eng_prod/crow/crow-complete.bash

# Set up scripts dir
export SCRIPTS_DIR='/google/src/head/depot/google3/experimental/users/brianmurray/scripts'
export X20_SCRIPTS_DIR='/google/data/ro/users/br/brianmurray/scripts'
export PATH=${PATH}:${SCRIPTS_DIR}:${X20_SCRIPTS_DIR}:$HOME/.local/bin:$HOME/scripts
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
alias emacs-daemon='emacs --daemon'
alias e='emacsclient -t'
alias ec='emacsclient -c'
alias ek="emacsclient -e '(kill-emacs)'"
if hash nvim 2>/dev/null; then
  alias vim='nvim'
fi

# Google specific

################################ AGSA ########################################
alias gsa-dump-state='~/scripts/gsa_dump_state.sh'
alias gsa-make='blaze run --config=android_arm //java/com/google/android/apps/gsa/velvet:install_velvet_dev'
alias gsa-test='vendor/unbundled_google/packages/GoogleSearch/velvettests'
alias cdg='cd $(pwd | awk -F google3 '"'"'{print $1"/google3/java/com/google/android/apps/gsa"}'"')"
alias cdgt='cd $(pwd | awk -F google3 '"'"'{print $1"/google3/javatests/com/google/android/apps/gsa"}'"')"


################################ Sidekick ####################################

################################ GWS #########################################
alias gws-build='blaze build -c opt //gws:gws //gws:dev_fileset'
alias gws-build-rabbit='rabbit build -c opt //gws:gws //gws:dev_fileset'
alias gws-build-debug="blaze build --copt=-O0 --per_file_copt='//gws,//webserver@-g' --strip=never gws:gws gws:dev_fileset"
alias gws-build-borg='blaze build -c opt //gws:gws //gws/tools:build_custom_googledata_tarball'
alias gws-run='gws/tools/startgws.py --binary=blaze-bin/gws/gws --alsologtostderr'
alias gws-run-debug='gws/tools/startgws.py --port=8887 --binary=blaze-bin/gws/gws --fileset=startgws_fileset --debug --debug_args=--breakpoint=main --addarg=install_watchdog_in_gws_ss=false --addarg=xfe_watchdog_timeout_seconds=480'
alias gws-run-borg='/google/data/ro/projects/gws/tools/start_gws_on_borg     --keep_running     --cell=pa     --use_custom_googledata      --custom_googledata_tarball_output_path=$PWD/blaze-bin/gws/tools/googledata.tgz     --sffe_rebuild_data_tarball     --borg_ephemeral_packages --charged_user=eval-service-quality'
alias gws-run-with-gfe='gws/tools/startgws.py --port=8887 --also_launch_gfe --gfe_ssl_port=8886 --binary=blaze-bin/gws/gws --alsologtostderr'
alias gws-sync-green='/home/build/static/projects/testing/tap/scripts/tap_sync gws,gws.googledata,gws.binary_and_data'
alias gws-instanter='/google/data/ro/projects/gws/tools/start_gws_on_borg --instanter  --always_sync'

################################ Doodles ######################################
alias pineapple-make='blaze run --android_sdk=//third_party/java/android/android_sdk_linux/platforms/prerelease:android_sdk_tools //java/com/google/android/apps/doodles/pineapple:run'
alias vday-make='blaze run //java/com/google/android/apps/doodles/vday17:run'
alias cdv='cd $(pwd | awk -F google3 '"'"'{print $1"/google3/googledata/html/js/egg/vday17"}'"')"
alias cddb='cd $(pwd | awk -F google3 '"'"'{print $1"/google3/third_party/javascript/doodle_blocks"}'"')"
alias cdf='cd $(pwd | awk -F google3 '"'"'{print $1"/google3/googledata/html/js/egg/fischinger"}'"')"
alias cdl='cd $(pwd | awk -F google3 '"'"'{print $1"/google3/googledata/html/js/egg/logo17"}'"')"
alias cdc='cd $(pwd | awk -F google3 '"'"'{print $1"/google3/services/appengine/internal_apps/doodlecannon"}'"')"
alias cdx='cd /google/data/rw/users/br/brianmurray'
alias cdex='cd $(pwd | awk -F google3 '"'"'{print $1"/google3/experimental/users/brianmurray"}'"')"
alias cdwasm='cd $(pwd | awk -F google3 '"'"'{print $1"/google3/experimental/doodles/hackathon/wasm"}'"')"

################################# Shared #######################################
alias milldump='/google/data/ro/projects/logs/milldump'
alias aswb='/opt/android-studio-with-blaze-stable/bin/studio.sh'
alias killaswb='ps -Af | egrep "aswb|blaze" | awk '\''{print $2}'\'' | xargs kill -9'
alias cdg='cd $(pwd | awk -F google3 '"'"'{print $1"/google3"}'"')"
alias g5='git5'
alias g4-basecl='srcfs get_readonly'
alias open='gnome-open'
alias va='find -L . -type f -exec vim {} +'
alias fix-auth='eval $(ssh-agent -s)'
alias tmux='/usr/bin/tmx'


function run_doodle_server() {
    if [ -n "$TMUX" ]; then
        tmux rename-window $1
    fi
    ./run_local_demo.sh $1
}

function oskar_demo() {
    cdf
    run_doodle_server $1
}

function logo_on_appengine() {
  stage_on_appengine.sh logo17 2017 $1
}

function logo_on_public_appengine() {
  stage_on_appengine.sh logo17 2017 $1 true
}

function update_logo_stable() {
  logo_on_appengine logo-stable && logo_on_public_appengine logo-stable
}

function sidekick_run() {
  PORT=9999
  if [ -n $1 ]; then
    PORT=$1
  fi
  g5d
  java/com/google/geo/sidekick/scripts/run_frontend --build --blaze --port=$PORT --gaia=prod
}

dircolors /usr/local/google/home/brianmurray/.dir_colors/dircolors


export P4DIFF='vimdiff -f'
export P4MERGE='vimmerge'

# Use ADB turbo whenever possible - otherwise fallback to standard adb.

ANDROID_SDK_HOME=/google/src/head/depot/google3/third_party/java/android/android_sdk_linux
export PATH=${PATH}:${ANDROID_SDK_HOME}/platform-tools:${ANDROID_SDK_HOME}/tools
#export PATH=${HOME}/opt/platform-tools-1.0.39:${PATH}

#function adb() {
#    EMU_DEPS=/google/data/ro/teams/mobile_eng_prod/emu/live/google3/
#    ANDROID_SDK=${EMU_DEPS}/third_party/java/android/android_sdk_linux/
#    EMU_SUPPORT=${EMU_DEPS}/tools/android/emulator/support/
#    ANDROID_ADB=${ANDROID_SDK}/platform-tools/adb
#    ANDROID_ADB=${ANDROID_ADB} $EMU_SUPPORT/adb.turbo "$@"
#}

export FZF_DEFAULT_COMMAND='find .'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash


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

# /PERSONAL SETTINGS

# X20 writable user dir
#export XHOME=/google/data/rw/users/${USER:0:2}/$USER

# KHOM STUFF

###############
# Bash history
#  
#  # If set, the history list is appended to the file named by the value of the
#  # HISTFILE variable when the shell exits, rather than overwriting the file.
#  shopt -s histappend
#  # If set, bash attempts to save all lines of a multiple-line command in the
#  # same history entry. This allows easy re-editing of multi-line commands.
#  shopt -s cmdhist
#  # If set, bash checks the window size after each command and, if necessary,
#  # updates the values of LINES and COLUMNS.
#  shopt -s checkwinsize
#  # http://wiki.corp.google.com/twiki/bin/view/Main/BashTipsByNik
#  # A value of erasedups causes all previous lines matching the current line to be
#  # removed from the history list before that line is saved.
#  HISTCONTROL=erasedups
#  # Format string for strftime(3) to print the time stamp associated with each
#  # history entry displayed by the history builtin.
#  HISTTIMEFORMAT="%F %T " # %Y-%m-%d %H:%M:%S
#  #HISTTIMEFORMAT='%F %R ' # %Y-%m-%d %H:%M
#  # Must be set in /etc/bash.bashrc to avoid truncation upon opening new shells.
#  # The maximum number of lines contained in the history file.
#  # Numeric values less than zero inhibit truncation
#  HISTFILESIZE=-1
#  # Must be set in /etc/bash.bashrc to avoid truncation upon opening new shells.
#  # The number of commands to remember in the command history.
#  # Numeric values less than zero result in every command being saved on the
#  # history list (there is no limit).
#  HISTSIZE=-1
#  # Flush history to file on each command.
#  # -a Append the "new" history lines (history lines entered since the #
#  #    beginning of the current bash session) to the history file.
#  # -n Read the history lines not already read from the history file into the
#  #    current history list. These are lines appended to the history file since
#  #    the beginning of the current bash session.
#  export PROMPT_COMMAND="history -a; history -n; source_bashrc_if_changed;"
#  #trap 'history -a; history -n;' DEBUG
#  # Set this last to avoid truncating the file
#  HISTFILE=$XHOME/.bash_history
#  ls -l $HISTFILE
#  set | grep -E '^HIST(FILE)?SIZE'
#  
# /KHOM STUFF
