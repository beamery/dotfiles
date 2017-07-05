#!/bin/bash
# jartps1.sh - An enhanced bash prompt for Googlers
# Author:   Justine Tunney <jart@google.com>
# Modified: 2014-06-20
#
# Do you get frustrated by extremely long source code directories that leave no
# room to type commands? Do you wish there was a more human-friendly way to
# keep track of what you're doing in the terminal? Then this easy-to-use script
# might be the answer.
#
# LIST OF BASH PROMPT ENHANCEMENTS
#
#   - Shorten /x/y/z/google3/... paths to //...
#   - Show current git branch.
#   - Show current citc client name.
#   - Shorten x20 paths.
#   - Show background job count if \j > 0.
#   - Show process exit code if $? != 0.
#   - ABSOLUTELY NO SLUGGISHNESS OR PROMPT LATENCY.
#   - Doesn't look *too* unfamiliar compared to bash defaults.
#
# TRY IT OUT
#
#   JARTPS1_THEME=dark source /google/data/ro/users/ja/jart/bin/jartps1.sh
#
# INSTALLATION
#
#   cp /google/data/ro/users/ja/jart/bin/jartps1.sh ~/.jartps1.sh
#   echo "JARTPS1_THEME=dark source .jartps1.sh" >>~/.bashrc
#
# CUSTOMIZING
#
#   Copy/paste the `PS1="..."` line from this file and add it to your bashrc
#   after the line where you source this file and refer to the `man bash`
#   section titled "PROMPTING".
#
#   If you're using a black background terminal (as you should!!) then you
#   might want to customize the color and make things look more fabulous. You
#   just have to figure out the ANSI escape codes for the colors you
#   want. Don't remove the 0's because they're used to reset the current
#   formatting. Also don't remove the \[...\] escapes or else bash will print
#   artifacts when you do things like reverse search. A library I wrote called
#   Fabulous will help you generate the escape codes:
#
#     $ sudo apt-get install python-pip
#     $ sudo pip install fabulous
#     $ python
#     >>> from fabulous import color
#     >>> color.red('hello')
#     u'\x1b[31mhello\x1b[39m'
#     >>> color.fg256('#ff6699', 'hello')
#     u'\x1b[38;5;204mhello\x1b[39m'
#     >>> color.bold(color.flip(color.fg256('indianred', 'hello')))
#     u'\x1b[1;7;38;5;167mhello\x1b[39;27;22m'
#
#   See also: https://github.com/jart/fabulous/blob/master/fabulous/color.py
#
# NOTES
#
#   This script will leave a tiny temp file behind for each terminal you
#   open. This isn't a problem because `/etc/cron.daily/tmpreaper` will delete
#   them after seven days or so.
#
# CHANGELOG
#
#   2014-06-20  Justine Tunney  <jart@google.com>
#
#     * Conform to go/bashstyle
#
#   2013-12-10  Justine Tunney  <jart@google.com>
#
#     * Fixed a bug which caused bash to display a warning each time the prompt
#       is displayed if a certain /tmp file got deleted by a weekly cleanup
#       cron job.
#
#     * Fixed ps1_error() and ps1_jobs() now that I understand bash arithmetic
#       expressions better.
#

case ${JARTPS1_THEME:-default} in
  default)
    PS1="\[\e[1;30m\]\D{%T }\[\e[1;31m\]\$(ps1_error)\[\e[34m\]\$(ps1_jobs \j)\[\e[32m\]\$(ps1_citc)\$(ps1_git)\$(ps1_x20)\$(ps1_fig)\[\e[0m\]\u@\h\[\e[m\]:\$(ps1_dir)\$ "
    PS2='> '
    PS4='+ '
    ;;
  dark)
    PS1="\[\e[1;30m\]\D{%T }\[\e[1;31m\]\$(ps1_error)\[\e[34m\]\$(ps1_jobs \j)\[\e[32m\]\$(ps1_citc)\$(ps1_git)\$(ps1_x20)\$(ps1_fig)\[\e[0;95m\]\u@\h\[\e[m\]:\[\e[0;96m\]\$(ps1_dir)\[\e[0m\]\$ "
    PS2='> '
    PS4='+ '
    ;;
  *)
    printf "Invalid \$JARTPS1_THEME: %s\n" "${JARTPS1_THEME}" >&2
    ;;
esac

ps1_error() {
  local -i err=$?
  if (( err != 0 )); then
    printf "\$?=%d " ${err}
  fi
}

ps1_jobs() {
  local -i count=$1
  if (( count > 0 )); then
    printf "jobs=%d " ${count}
  fi
}

ps1_citc() {
  local citc
  case "${PWD}" in
    /google/src/cloud/*/*/google3*)
      citc="${PWD#/google/src/cloud/*/}"
      citc="${citc/\/*/}"
      if [[ "${citc}" == switch_client ]]; then
          printf "switch:%s " "$(g4 switches | awk '{ print $2 }')"
      else
          printf "p4:%s " "${citc}"
      fi
      ;;
  esac
}

ps1_git() {
  local g5_client
  if jartps1_gitbranch_find; then
    g5_client="$(pwd | awk '/google3/ { match($0, /([^/]+)\/google3/, arr); print arr[1]}')"
    g5_client=${g5_client:-g5}
    printf  "%s:%s " "${g5_client}" "${jartps1_gitbranch}"
  fi
}

ps1_fig() {
  local fig_client
  if jartps1_figinfo_find; then
    fig_client="$(pwd | awk '/google3/ { match($0, /([^/]+)\/google3/, arr); print arr[1]}')"
    fig_client=${fig_client:-fig}
    printf  "%s:%s " "${fig_client}" "${jartps1_figinfo}"
  fi
}

ps1_x20() {
  local user
  case "${PWD}" in
    /google/data/ro/users/??/*)
      user="${PWD#/google/data/ro/users/??/}"
      user="${user/\/*/}"
      printf "x20:%s " "${user}"
      ;;
    /google/data/rw/users/??/*)
      user="${PWD#/google/data/rw/users/??/}"
      user="${user/\/*/}"
      printf "x20-rw:%s " "${user}"
      ;;
  esac
}

ps1_dir() {
  local path="${PWD}"
  case "${path}" in
    */google3)
      path="//"
      ;;
    */google3/*)
      path="//${path#*/google3/}"
      ;;
    /home/${USER})
      path="~"
      ;;
    /home/${USER}/*)
      path="~/${path#/home/*/}"
      ;;
    /usr/local/google/home/${USER})
      path="~"
      ;;
    /usr/local/google/home/${USER}/*)
      path="~/${path#/usr/local/google/home/*/}"
      ;;
    /google/data/r?/users/??/*)
      path="${path#/google/data/r?/users/??/*/}"
      case "${path}" in
        //google/data/r?/users/??/*)
          path="/"
          ;;
      esac
      ;;
  esac
  printf "%s" "${path}"
}

# Caches last directory for which `jartps1_gitdir_find` failed.
export JARTPS1_GITDIR_TMP="$(mktemp --suffix=-jartps1-gitdir)"

################################################################################
# Swiftly determine name of current Git branch.
#
# Arguments:
#   None
# Returns:
#   0 on success, storing result to ${jartps1_gitbranch}.
#   1 if ${PWD} isn't inside a Git repo.
# Globals:
#   jartps1_gitbranch      - Used to store result.
################################################################################
jartps1_gitbranch_find() {
  if jartps1_gitdir_find; then
    local head
    if read head <"${jartps1_gitdir}/.git/HEAD" &>/dev/null; then
      jartps1_gitbranch="${head##*/}"
      if [[ "${jartps1_gitbranch}" != "" ]]; then
        return 0
      fi
    fi
  fi
  return 1
}

jartps1_figinfo_find() {
  local hg_bookmark
  local hg_dir
  if [[ $PWD == *"/fig/"* ]]; then
    hg_dir="$(pwd | awk '/google3/ { match($0, /(.+)\/google3/, arr); print arr[1]}')"
    if [ "$hg_dir" != "" ] && [ -f $hg_dir/.hg/bookmarks.current ]; then
      hg_bookmark="$(cat $hg_dir/.hg/bookmarks.current)"
      jartps1_figinfo="$hg_bookmark"
    else
      jartps1_figinfo="$(hg id | awk '{ print $1 }')"
    fi
    return 0
  fi
  return 1
}

################################################################################
# Swiftly locate root of current Git repository.
#
# This is the fastest possible solution. Rather than the naïve approach of
# executing the git command (which could take hundreds of milliseconds), this
# routine launches no processes and only requires a few stat() system calls. In
# some cases it can avoid lookup or cache the result.
#
# Arguments:
#   dir                 - Optional, defaults to ${PWD}
# Returns:
#   0 on success, storing result to ${jartps1_gitdir}.
#   1 if dir isn't inside a Git repo.
# Globals:
#   jartps1_gitdir      - Used to store result.
#   JARTPS1_GITDIR_TMP  - Temp file used to cache last failed search.
################################################################################
jartps1_gitdir_find() {
  local dir="$1"
  if [[ -z "${dir}" ]]; then
    dir="${PWD}"
    case "${dir}" in
      /)                              return 1 ;;
      /google/*)                      return 1 ;;
      /home/build/*)                  return 1 ;;
      /home/${USER})                  return 1 ;;
      /usr/local/google/home/${USER}) return 1 ;;
    esac
    if [[ -f "${JARTPS1_GITDIR_TMP}" ]]; then
      local notgit
      if read notgit <"${JARTPS1_GITDIR_TMP}" &>/dev/null; then
        if [[ "${dir}" == "${notgit}" ]]; then
          return 1
        fi
      fi
    fi
  fi
  if [[ -d "${dir}/.git" ]]; then
    jartps1_gitdir="${dir}"
  else
    local parent="${dir%/*}"
    if [[ -z "${parent}" ]]; then
      printf "%s" "$PWD" >"${JARTPS1_GITDIR_TMP}"
      return 1
    fi
    jartps1_gitdir_find "${parent}"
  fi
}
