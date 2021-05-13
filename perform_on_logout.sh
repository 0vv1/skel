# file:    perform_on_logout.sh
# brief:   shell function to perform things before logout
# author:  (c) 2011 - 2021 Alexander Puls <https://0vv1.io>
# license: GPL v3 <https://opensource.org/licenses/GPL-3.0>
# ----------------------------------------------------------------------------
perform_on_logout() {
	if pgrep -x "syncthing" > /dev/null
	then
		p="$(pidof syncthing)"
		kill -TERM $p
	else
		echo "Syncting not running"
	fi
	sleep 1
	clear
	printf "\n  -------------- \033[1;33mexit\033[0m --------------\n"
	printf "  return \033[0;34mr\033[0m to \033[0;33mreboot\033[0m\n"
	printf "  return \033[0;34ms\033[0m to \033[0;33mshutdown\033[0m\n"
	printf "  return \033[0;34mb\033[0m to \033[0;33mbackup & logout\033[0m\n"
	printf "  return \033[0;34mB\033[0m to \033[0;33mbackup"
	printf " & shutdown\033[0m\n\n"
	printf "  or hit \033[0;34mRETURN\033[0m/\033[1;34mENTER\033[0m to just"
	printf " \033[0;33mlogout\033[0m\n"
	printf '%s\n\n' "  ----------------------------------"
	printf "       \033[1;32m>\033[0m " 
	read -r ANSWER
	printf "\n"
	case $ANSWER in
		b*) "${HOME}/bin/backup-home.sh" ;;
		B*) "${HOME}/bin/backup-home.sh" && /sbin/shutdown -ah now ;;
		r*) /sbin/shutdown -ar now ;;
		s*) /sbin/shutdown -ah now ;;
	esac
	sync
	printf "\n"
	sleep 1
	clear
}

# EOF $HOME/.local/lib/perform_on_logout.sh ----------------------------------
