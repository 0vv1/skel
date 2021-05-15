# file:    .profile
# brief:   sourced on invocation of sh(1) login shells
# author:  (c) 2011 - 2021 Alexander Puls <https://0vv1.io>
# license: GPL v3 <https://opensource.org/licenses/GPL-3.0>
# -------------------------------------------------------------------------
MEM_CACHE=true
GET_WEATHER=false

umask 0037

# XDG base directories ____________________________________________________
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
# shellcheck source=.config/user-dirs.dirs
if [ -f "${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs" ] ; then
    . "${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs"
    export XDG_DESKTOP_DIR XDG_DOCUMENTS_DIR XDG_MUSIC_DIR XDG_PICTURES_DIR
    export XDG_PUBLICSHARE_DIR XDG_TEMPLATES_DIR XDG_VIDEOS_DIR
fi

# RAM-disk & XDG_CACHE_HOME ____________________________________
MEM_DIR="/tmp/$(id -u)_$(date +%F)"

   # RAM-disk wanted and /tmp writable?
if [ "$MEM_CACHE" = true ] && [ -w /tmp ] && \
   # .. residing in memory?
   [ "$(df /tmp | awk 'END{print $1;exit}')" = "tmpfs" ] && \
   # .. and "enough" space on there? (32MB)
   [ "$(df /tmp | awk 'END{print $4;exit}')" -gt 32768 ] ; then
    if [ ! -d "${MEM_DIR}" ] ; then # already have a RAM-disk?
        mkdir -p "${MEM_DIR}"
    fi
    export XDG_CACHE_HOME="${MEM_DIR}"
    # generate link below $HOME
    if [ -d "${XDG_PUBLICSHARE_DIR}/cache" ] ; then
        rm -rf "${XDG_PUBLICSHARE_DIR}/cache"
    fi
    ln -fs "${XDG_CACHE_HOME}" "${XDG_PUBLICSHARE_DIR}/cache"
else # .. or fallback to (persistent) disk cache
    export XDG_CACHE_HOME="${XDG_PUBLICSHARE_DIR}/cache"
fi

# populating cache _______________________________ 
if [ ! -d "${XDG_CACHE_HOME}/polipo" ] ; then
    mkdir -p  "${XDG_CACHE_HOME}/polipo"
fi
if [ ! -d "${XDG_CACHE_HOME}/.thumbnails" ] ; then
    mkdir -p "${XDG_CACHE_HOME}/.thumbnails"
fi # pushing picture thumbnails into memory
ln -fs "${XDG_CACHE_HOME}/.thumbnails" "${HOME}/"

# custom config & directory paths _______________
export CCACHE_DIR="${XDG_CACHE_HOME}/ccache"
export GEO_LAT="${XDG_CACHE_HOME}/geo.latitude"
export GEO_LONG="${XDG_CACHE_HOME}/geo.longitude"
export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"
export JAVA_HOME="/usr/lib/jvm/default/java"
export KEY_DIR="${XDG_DOCUMENTS_DIR}/schlussel"
export LESSHISTFILE="/dev/null"    # less history
export LIB_DIR="${HOME}/.local/lib"
export LOG_DIR="${HOME}/.local/var/log"
export QT_QPA_PLATFORMTHEME="gtk2" # GTK for Qt
export WINEPREFIX="/opt/wine"
XINITRC="${XDG_CONFIG_HOME}/xinitrc"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# shell environment _______________________________________________
export HISTFILE="${LOG_DIR}/history"
export HISTIGNORE="?:??:clear:exit:history:mount:umount:pwd:[ \t]*"
export HISTSIZE="30000"
export SAVEHIST="300000"
if [ -x "${HOME}/.local/bin/zsh" ] ; then
    export SHELL='${HOME}/.local/bin/zsh'           # default shell
else
    if [ -x "/bin/zsh" ] ; then
        export SHELL='/bin/zsh'
    fi
fi

# GPG env ______
GPG_TTY="$(tty)"
export GPG_TTY

# TeX env ______________________________________________________
export TEXINPUTS=".:${XDG_PICTURES_DIR}/icons.pdf//"
export TEXINPUTS=":${TEXINPUTS}:${XDG_PICTURES_DIR}/icons.svg//"
export TEXINPUTS="${TEXINPUTS}:${XDG_TEMPLATES_DIR}/texfm//"

# exec paths ____________________________________________________
PATH="/usr/lib/colorgcc/bin/:/usr/lib/jvm/java-8-jdk/bin:${PATH}"
PATH="/usr/bin/core_perl:/usr/lib/ccache/bin/:${PATH}"
PATH="${HOME}/.local/bin:${XDG_DESKTOP_DIR}/bin:${PATH}"
export PATH

# colors for raw console _______
if [ "${TERM}" = "linux" ]; then
    printf "\033]P1B35964"  # red
    printf "\033]P264B359"  # green
    printf "\033]P3B3A859"  # yellow
    printf "\033]P47987F2"  # blue
    printf "\033]P5CC6CD9"  # magenta
    printf "\033]P6A2C1F5"  # lightblue (cyan)
    printf "\033]P7C3B8A1"  # white
    printf "\033]P89B8B78"  # white3 (black2)
    printf "\033]P9BF431D"  # red2
    printf "\033]PA789C80"  # green2
    printf "\033]PB735D4F"  # brown (yellow2)
    printf "\033]PC80789C"  # blue2
    printf "\033]PDAC1DBF"  # magenta2
    printf "\033]PE3DABCC"  # cyan2
    printf "\033]PFEAE6CA"  # oyster (white2) -> foreground as well
    clear                   # repaint
fi

# autostarts ______________________________
if pgrep -x "syncthing" > /dev/null ; then
    echo "Syncthing already running" ; else
    syncthing -no-browser &
fi

# functions _______________________
. "${LIB_DIR}/get_location.sh"
. "${LIB_DIR}/perform_on_logout.sh"

# weather forecast service ____________
get_location
if [ "$GET_WEATHER" = true ] ; then
    ${HOME}/.local/bin/get-weather.sh &
fi

# X server autostart (at vt1, depending on host) ___________
if [ "$(hostname)" = "am1i" ]; then
    if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ] ; then
        startx "${XINITRC}"
    fi
fi

# before logout _____________
trap 'perform_on_logout' EXIT

# EOF $HOME/.profile ------------------------------------------------------
