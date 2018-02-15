# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
source /google/src/head/depot/google3/quality/ui/doodles/tools/bashrc

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
export PATH='/usr/local/google/home/brianmurray/.linuxbrew/bin:/usr/local/google/home/brianmurray/.linuxbrew/sbin':"$PATH"
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
alias vim='vim --servername vi_main'
if hash nvim 2>/dev/null; then
  alias vim='nvim'
fi

# Google specific
export EGG=googledata/html/js/egg

function g3() {
  echo ${PWD%google3*}google3
}

function cdg() {
  if [ -n $2 ]; then
    cd ${PWD%google3*}google3/$1/$2
  else
    cd ${PWD%google3*}google3/$1
  fi
}

################################ AGSA ########################################
alias gsa-dump-state='~/scripts/gsa_dump_state.sh'
alias gsa-make='blaze mobile-install --config=android_arm //java/com/google/android/apps/gsa/binaries/velvet:velvet_dev'
alias gsa-test='vendor/unbundled_google/packages/GoogleSearch/velvettests'


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
alias gws-sync-green='cdg; gws/tools/sync_to_green.sh'
alias gws-instanter='/google/data/ro/projects/gws/tools/start_gws_on_borg --instanter  --always_sync'
alias fastgws='/google/src/head/depot/google3/gws/tools/fastgws/fastgws'

################################ Doodles ######################################
alias cannon-run-local='services/appengine/internal_apps/doodlecannon/app.sh deploy local --port=8080 --dev_appserver_admin_port=8000'
alias cannon-prod-data='services/appengine/internal_apps/doodlecannon/dataloader.sh --test_server="localhost:8080"'
alias pineapple-make='blaze run --android_sdk=//third_party/java/android/android_sdk_linux/platforms/prerelease:android_sdk_tools //java/com/google/android/apps/doodles/pineapple:run'
alias vday-make='blaze run //java/com/google/android/apps/doodles/vday17:run'
alias cdegg='cdg $EGG'
alias cdv='cdg $EGG/vday17'
alias cdf='cdg $EGG/fischinger'
alias cdl='cdg $EGG/logo17'
alias cddb='cdg third_party/javascript/doodle_blocks'
alias cddc='cdg services/appengine/internal_apps/doodlecannon'
alias cdsd='cdg services/appengine/apps/slashdoodles'
alias cdex='cdg experimental/users/brianmurray'
alias cdx='cd /google/data/rw/users/br/brianmurray'

################################# Shared #######################################
alias milldump='/google/data/ro/projects/logs/milldump'
alias aswb='/opt/android-studio-with-blaze-stable/bin/studio.sh'
alias killaswb='ps -Af | egrep "aswb|blaze" | awk '\''{print $2}'\'' | xargs kill -9'
alias g5='git5'
alias g4-basecl='srcfs get_readonly'
alias open='gnome-open'
alias va='find -L . -type f -exec vim {} +'
alias fix-auth='eval $(ssh-agent -s)'
alias tmux='tmx2'
alias tmux-kill-dupes="tmx2 ls | awk -F ':' ' /^_/ { print \$1 }' | xargs -L 1 tmx2 kill-session -t"
alias blaze-run='/google/src/files/head/depot/google3/devtools/blaze/scripts/blaze-run.sh'

function stage_sandbox() {
  cdg
  time googledata/html/js/egg/stage_doodle_on_borg.sh --sandbox=true --user=searchui --priority=200 --dc=$1 --ogs_dc=$1 --require_login=false --force_uncacheable=true --dir=googledata/html/logos/2017/$2
}

function stage_versioned_sandbox() {
  cdg
  if [ -n $3 ]; then
    googledata/html/js/egg/stage_versioned_doodle_on_borg.sh --source_dir=$EGG/$2 --dc=$1 --ogs_dc=$1 --version=$3
  else
    googledata/html/js/egg/stage_versioned_doodle_on_borg.sh --source_dir=$EGG/$2 --dc=$1 --ogs_dc=$1
  fi
}

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
  cdg
  PORT=9999
  if [ -n $1 ]; then
    PORT=$1
  fi
  java/com/google/geo/sidekick/scripts/run_frontend --build --blaze --port=$PORT --gaia=prod
}

function desktop_ntp() {
  CELL='wk'
  if [ -n $1 ]; then
    CELL=$1
  fi
  /opt/google/chrome/chrome --enable-instant-extended-api --google-base-url=https://sky-brianmurray-'$CELL'-gws.sandbox.google.com --use-cacheable-new-tab-page
}

function android_ntp() {
  CELL='wk'
  if [ -n $1 ]; then
    CELL=$1
  fi
  /google/data/ro/users/kh/khom/bin/crow_chrome_ntp.sh --google_base_url=http://sky-brianmurray-$CELL-gws.sandbox.google.com/
}

function run_slashdoodles() {
  cdg
  VERSION_TAG='test'
  if [-n $1 ]; then
    VERSION_TAG=$1
  fi
  services/appengine/apps/slashdoodles/app.sh deploy prod --version_tag=$VERSION_TAG
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

#export FZF_DEFAULT_COMMAND='find . -maxdepth 1'
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

## Set the Hi status to be displayed as part of the prompt. #!>>HI<<!#
#PS1="\[\${__hi_prompt_color}\]\${__hi_prompt_text}\[${__hi_NOCOLOR}\]${PS1}" #!>>HI<<!#
## Set the default values for the text of the hi prompt. Change these if you like. #!>>HI<<!#
#__hi_on_prompt="[hi on] " #!>>HI<<!#
#__hi_off_prompt="[hi off]" #!>>HI<<!#


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
