# file:    set_root_window_name.sh
# brief:   shell function to set root window name in X11
# author:  (c) 2011 - 2021 Alexander Puls <https://0vv1.io>
# license: GPL v3 <https://opensource.org/licenses/GPL-3.0>
# -------------------------------------------------------------------------
set_root_window_name() {
  while true ; do
    LCL=$(date +%a\ %H:%M)
    UTC=$(TZ=UTC date +%H:%M\ %Z)
    MEM_FREE=$(free -h --kilo | awk '/^Mem:/ {print $3 "/" $2}')
    if [ -r "${XDG_CACHE_HOME}/geo.weather" ] && \
      [ -n "$(cat ${XDG_CACHE_HOME}/geo.weather)" ]; then
      WTR=$(cat ${XDG_CACHE_HOME}/geo.weather)
	  if [ -r "${XDG_CACHE_HOME}/notification" ] && \
        [ -n "$(cat ${XDG_CACHE_HOME}/notification)" ] ; then
        NOTE=$(cat ${XDG_CACHE_HOME}/notification)
        xsetroot -name " ${LCL} (${UTC}) | ${MEM_FREE} | ${NOTE} | ${WTR} "
      else 
        xsetroot -name " ${LCL} (${UTC}) | ${MEM_FREE} | ${WTR} "
	  fi
    else
	  if [ -r "${XDG_CACHE_HOME}/notification" ] && \
        [ -n "$(cat ${XDG_CACHE_HOME}/notification)" ] ; then
        NOTE=$(cat ${XDG_CACHE_HOME}/notification)
        xsetroot -name " ${LCL} (${UTC}) | ${MEM_FREE} | ${NOTE} "
      else
      xsetroot -name " ${LCL} (${UTC}) | ${MEM_FREE} "
      fi
    fi
    sleep $((60 - $(date +%S) % 60))
  done
}

# EOF $HOME/.local/lib/set_root_window_name.sh ----------------------------
