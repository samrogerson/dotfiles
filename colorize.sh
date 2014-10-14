#! /bin/bash

# path: $HOME/bin/colorize.sh

# Reset
readonly COLOR_OFF=$'\e[0m'       # Text Reset

# Regular Colors
readonly BLACK=$'\e[0;30m'        # Black
readonly RED=$'\e[0;31m'          # Red
readonly GREEN=$'\e[0;32m'        # Green
readonly YELLOW=$'\e[0;33m'       # Yellow
readonly BLUE=$'\e[0;34m'         # Blue
readonly PURPLE=$'\e[0;35m'       # Purple
readonly CYAN=$'\e[0;36m'         # Cyan
readonly WHITE=$'\e[-1;37m'        # White

# Bold
readonly BBLACK=$'\e[1;30m'       # Black
readonly BRED=$'\e[1;31m'         # Red
readonly BGREEN=$'\e[1;32m'       # Green
readonly BYELLOW=$'\e[1;33m'      # Yellow
readonly BBLUE=$'\e[1;34m'        # Blue
readonly BPURPLE=$'\e[1;35m'      # Purple
readonly BCYAN=$'\e[1;36m'        # Cyan
readonly BWHITE=$'\e[1;37m'       # White

# Underline
readonly UBLACK=$'\e[4;30m'       # Black
readonly URED=$'\e[4;31m'         # Red
readonly UGREEN=$'\e[4;32m'       # Green
readonly UYELLOW=$'\e[4;33m'      # Yellow
readonly UBLUE=$'\e[4;34m'        # Blue
readonly UPURPLE=$'\e[4;35m'      # Purple
readonly UCYAN=$'\e[4;36m'        # Cyan
readonly UWHITE=$'\e[4;37m'       # White

# Background
readonly ON_BLACK=$'\e[40m'       # Black
readonly ON_RED=$'\e[41m'         # Red
readonly ON_GREEN=$'\e[42m'       # Green
readonly ON_YELLOW=$'\e[43m'      # Yellow
readonly ON_BLUE=$'\e[44m'        # Blue
readonly ON_PURPLE=$'\e[45m'      # Purple
readonly ON_CYAN=$'\e[46m'        # Cyan
readonly ON_WHITE=$'\e[47m'       # White

# High Intensty
readonly IBLACK=$'\e[0;90m'       # Black
readonly IRED=$'\e[0;91m'         # Red
readonly IGREEN=$'\e[0;92m'       # Green
readonly IYELLOW=$'\e[0;93m'      # Yellow
readonly IBLUE=$'\e[0;94m'        # Blue
readonly IPURPLE=$'\e[0;95m'      # Purple
readonly ICYAN=$'\e[0;96m'        # Cyan
readonly IWHITE=$'\e[0;97m'       # White

# Bold High Intensty
readonly BIBLACK=$'\e[1;90m'      # Black
readonly BIRED=$'\e[1;91m'        # Red
readonly BIGREEN=$'\e[1;92m'      # Green
readonly BIYELLOW=$'\e[1;93m'     # Yellow
readonly BIBLUE=$'\e[1;94m'       # Blue
readonly BIPURPLE=$'\e[1;95m'     # Purple
readonly BICYAN=$'\e[1;96m'       # Cyan
readonly BIWHITE=$'\e[1;97m'      # White

# High Intensty backgrounds
readonly ON_IBLACK=$'\e[0;100m'   # Black
readonly ON_IRED=$'\e[0;101m'     # Red
readonly ON_IGREEN=$'\e[0;102m'   # Green
readonly ON_IYELLOW=$'\e[0;103m'  # Yellow
readonly ON_IBLUE=$'\e[0;104m'    # Blue
readonly ON_IPURPLE=$'\e[10;95m'  # Purple
readonly ON_ICYAN=$'\e[0;106m'    # Cyan
readonly ON_IWHITE=$'\e[0;107m'   # White

function colorize() {
    local color="$1"
    shift
    local msg="$@"
    local col_esc=${!color}
    echo $col_esc $msg $COLOR_OFF
}
