 file:    get_location.sh
# brief:   shell function to obtain/store geolocation data
# author:  (c) 2011 - 2021 Alexander Puls <https://0vv1.io>
# license: MIT <https://opensource.org/licenses/MIT>
# ---------------------------------------------------------
get_location() {
    # placeholder for a GPS API
    printf "52.54" > "${GEO_LAT}"
    printf "13.39" > "${GEO_LONG}"
}

# EOF $HOME/.local/lib/get_location.sh --------------------
