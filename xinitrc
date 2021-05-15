# file:    xinitrc
# brief:   initialisation script for X11
# author:  (c) 2009 - 2021 Alexander Puls <https://0vv1.io>
# license: MIT <https://opensource.org/licenses/MIT>
# -------------------------------------------------------------

# global config ____________________________
if [ -d /etc/X11/xinit/xinitrc.d ] ; then 
    for f in /etc/X11/xinit/xinitrc.d/?*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# funtions ___________________________
. "${LIB_DIR}/set_root_window_name.sh"

# log file _________________________________________
if [ -z "$HOSTNAME" ]; then
    ERRFILE="${LOG_DIR}/xsession-errors"
else
    ERRFILE="${LOG_DIR}/xsession-errors.${HOSTNAME}"
fi

# fonts _____________________________
xset +fp "${HOME}/.local/share/fonts"
xset fp rehash

# X11 apps ________________________________
xrdb -merge "${XDG_CONFIG_HOME}/Xresources"

# keyboard ___________________________________________
setxkbmap us -variant altgr-intl -option compose:rctrl

# display _____________________________________________________
xautolock -time 124 -locker slock &
if [ -r "${XDG_CONFIG_HOME}/desktop.pic" ] ; then
    feh --no-fehbg --bg-center "${XDG_CONFIG_HOME}/desktop.pic"
fi

# status bar via xsetroot
set_root_window_name &

# window managers _________
exec ${HOME}/.local/bin/dwm
#exec openbox-session

# EOF $XDG_CONFIG_HOME/xinitrc --------------------------------
