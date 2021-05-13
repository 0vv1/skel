# file:	   .zshenv
# brief:   parsed by every Z-shell instance upon start
# author:  (c) 2014 - 2021 Alexander Puls <https://0vv1.io>
# license: MIT <https://opensource.org/licenses/MIT>
# -----------------------------------------------------------------------
export FPATH="/usr/share/zsh/functions:$FPATH"
export HISTORY_IGNORE="(?|??|clear|exit|history|mount|umount|pwd|[ \t]*)"
export GITSTATUS_CACHE_DIR="${XDG_DATA_HOME}/zsh"

# options ___________________
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

# EOF $ZDOTDIR/.zshenv --------------------------------------------------
