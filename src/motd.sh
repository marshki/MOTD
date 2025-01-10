#!/usr/bin/env bash
#
# motd
#
# Message of the day (MOTD) for interactive shells in BSD & GNU/Linux.
# For wired rigs @ NYU's: Center for Brain Imaging, Center for Neural Science,
# & Department of Psychology.
#
# Author: M. Krinitz <mjk235 [at] nyu [dot] edu>
#
# Date: 2018.09.28
# License MIT

##############
# Header Array
##############

HEADR=(
"HOSTNAME(FQDN)"
"LAST LOGIN"
UPTIME
"LOAD AVGS."
"RUNNING PROCESSES"
"MEMORY USAGE"
"DISK USAGE"
"IP ADDRESS"
"MAC ADDRESS")

###########
# Variables
###########

# fully-qualified domain name
host_name=$(hostname -f)

# last login
last_login=$(last | awk 'NR==1' | tr -s ' ')

# uptime: days hours:minutes
time_up=$(uptime | sed 's/,//g' | awk '{ print $3,$4,$5}')

# load avgs. over the past 1,5,15 min. intervals
load_avg=$(uptime | awk '{ sub(/^.*: /, ""); print; }')
 
# running processes
procs=$(ps ax | wc -l | tr -d " ")
 
# disk stats: size used avail. capacity in GBs
disk_usg=$(df -H | awk '$NF == "/" {print $2,$3,$4,$5}')

###########
# FUNCTIONS
###########
  
# Print the MOTD header with appropriate values
print_header() {
  local title=$1
  local value=$2
  printf -- '%.30s: %s\n' "${title}$(dot 30 .)" "${value}"
}
  
# ASCII mouse w/text box, centered
maus() {
printf '
                             )            
                            (__        -----------------------
                            _  )_      < CBI//CNS//PSYCH TEK >
                           (_)_(_)     -----------------------
                            (o o)  _ _/
                           ==\o/==

'
}

# Print horizontal line of characters
# shellcheck disable=SC2183
dot() {
    printf '%*s\n' "${1:-$:COLUMNS}" | tr ' ' "${2:-#}"
}

#################
# Meat & Potatoes
#################

# Suppress last login for macOS
[ "$(uname -s)" = "Darwin" ] && touch ~/.hushlogin

case $(uname -s) in
Darwin)
  # Memory free/used
  mem=$(top -l 1 -s 0 | awk '/PhysMem/ {print $2,$6}')

  # IP address
  eth0=$(ipconfig getifaddr en0)

  # MAC address
  macaddr=$(ifconfig en0 | awk '/ether/{print $2}')
 ;;
Linux)
  # Memory free/used
  mem=$(free -g |awk 'FNR==2 {print $3, $4}')
 
  # get IP address for eth0 (primary)
  eth0=$(hostname --all-ip-addresses |awk '{printf $1}')
 
  # MAC address
  macaddr=$(ip addr show eth0 |awk '/ether/{print $2}')
 ;;
*)
  printf "%s\n" "Unsupported OS: $(uname -s)"
;;
esac

maus

print_header "${HEADR[0]}" "${host_name}"
print_header "${HEADR[1]}" "${last_login}"
print_header "${HEADR[2]}" "${time_up}"
print_header "${HEADR[3]}" "${load_avg} (1 min 5 mins 15 mins)"
print_header "${HEADR[4]}" "${procs} (total)"
print_header "${HEADR[5]}" "${mem} (used unused)"
print_header "${HEADR[6]}" "${disk_usg} (size used avail capacity)"
print_header "${HEADR[7]}" "${eth0}"
print_header "${HEADR[8]}" "${macaddr}"
