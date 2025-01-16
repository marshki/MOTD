#!/usr/bin/env bash
#
# motd
#
# Message of the day (MOTD) for interactive shells in BSD & GNU/Linux.
# For wired rigs @ New York University.
#
# Author: M. Krinitz <mjk235 [at] nyu [dot] edu>
#
# Date: 2024.01.16
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
# Functions
###########

time_up() {
  # Parse uptime to handle both 'day' and non-'day' cases
  local uptime_info
  uptime_info=$(uptime | sed 's/,//g')

  printf "%s\n" "$uptime_info" | awk '
    / day/ { print $3, $4, $5 }
    !/ day/ { print $3 }
  '
}

maus() {
  # ASCII mouse w/text box, centered
  printf '
                             )
                            (__        -----------------------
                            _  )_      < CBI//CNS//PSYCH TEK >
                           (_)_(_)     -----------------------
                            (o o)  _ _/
                           ==\o/==

'
}

dot() {
  # Print a horizontal line of characters
  printf '%*s\n' "${1:-${COLUMNS}}" | tr ' ' "${2:-#}"
}

###########
# Variables
###########

# Fully-qualified domain name
host_name=$(hostname -f)

# Last login
last_log=$(last | awk 'NR==1' | tr -s ' ')

# Uptime
time_up_result=$(time_up)

# Load averages (1 min 5 mins 15 mins)
load_avg=$(uptime | awk '{ sub(/^.*: /, ""); print; }')

# Running processes (total)
procs=$(ps ax | wc -l | tr -d " ")

# Memory usage (used, unused)
if [[ "$(uname -s)" == "Darwin" ]]; then
  mem=$(top -l 1 -s 0 | awk '/PhysMem/ {print $2,$6}')
else
  mem=$(free -g | awk 'FNR==2 {print $3, $4}')
fi

# Disk usage (size, used, avail, capacity)
if [[ "$(uname -s)" == "Darwin" ]]; then
  disk_usg=$(df -h | awk '$NF == "/" {print $2, $3, $4, $5}')
else
  disk_usg=$(df -h --output=size,used,avail,pcent,target | awk '$5 == "/" {print $1, $2, $3, $4}')
fi

# IP address
if [[ "$(uname -s)" == "Darwin" ]]; then
  eth0=$(ipconfig getifaddr en0)
else
  eth0=$(hostname --all-ip-addresses | awk '{printf $1}')
fi

# MAC address
if [[ "$(uname -s)" == "Darwin" ]]; then
  macaddr=$(ifconfig | awk '/ether/ {print $2; exit}')
else
  macaddr=$(ip link | awk '/ether/ {print $2; exit}')
fi

#################
# Meat & Potatoes
#################

maus

printf -- '%.30s: %s\n' "${HEADR[0]}$(dot 30 .)" "${host_name}"
printf -- '%.30s: %s\n' "${HEADR[1]}$(dot 30 .)" "${last_log}"
printf -- '%.30s: %s\n' "${HEADR[2]}$(dot 30 .)" "${time_up_result}"
printf -- '%.30s: %s\n' "${HEADR[3]}$(dot 30 .)" "${load_avg} (1 min 5 mins 15 mins)"
printf -- '%.30s: %s\n' "${HEADR[4]}$(dot 30 .)" "${procs} (total)"
printf -- '%.30s: %s\n' "${HEADR[5]}$(dot 30 .)" "${mem} (used unused)"
printf -- '%.30s: %s\n' "${HEADR[6]}$(dot 30 .)" "${disk_usg} (size used avail capacity)"
printf -- '%.30s: %s\n' "${HEADR[7]}$(dot 30 .)" "${eth0}"
printf -- '%.30s: %s\n' "${HEADR[8]}$(dot 30 .)" "${macaddr}"
