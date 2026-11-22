#!/usr/bin/env bash
#
# motd
#
# Message of the day (MOTD) for interactive shells on macOS
# & GNU/Linux (Debian, Raspberry Pi OS, RHEL, and Ubuntu.
# For wired rigs @ New York University.
#
# Bash 3.2
#
# Author: M. Krinitz <mjk235 [at] nyu [dot] edu>
#
# Date: 2026.08.26
# License MIT

#########
# Helpers
#########

maus() {
  # ASCII mouse with logo; heredoc prints as written
  cat <<'ART'

                             )
                            (__        -----------------------
                            _  )_      < CBI//CNS//PSYCH TEK >
                           (_)_(_)     -----------------------
                            (o o)  _ _/
                           ==\o/==

ART
}

dot() {
  # print a line of characters: width $1, character $2
  # shellcheck disable=SC2183
  printf '%*s\n' "${1:-$COLUMNS}" | tr ' ' "${2:-#}"
}

print_header() {
  # label padded with dots to 30 columns, then the value (or n/a)
  printf -- '%.30s: %s\n' "$1$(dot 30 .)" "${2:-n/a}"
}

format_uptime() {
  # $1: uptime in seconds; prints "Xd Xh Xm" (days omitted when zero)
  local secs=$1 days hours mins
  [[ -n "$secs" ]] || return

  days=$((secs / 86400))
  hours=$((secs % 86400 / 3600))
  mins=$((secs % 3600 / 60))

  if (( days > 0 )); then
    printf "%dd %dh %dm\n" "$days" "$hours" "$mins"
  else
    printf "%dh %dm\n" "$hours" "$mins"
  fi
}

######
# Main
######

main() {
  local host_name today procs

  # same on every OS
  host_name=$(hostname -f 2>/dev/null || hostname 2>/dev/null)
  today=$(date +"%A, %B %d, %Y %H:%M %Z")
  procs=$(ps -A -o pid= 2>/dev/null | wc -l | tr -d ' ')

  # OS-specific values
  case "$(uname -s)" in
  Darwin)
    boot_time=$(sysctl -n kern.boottime 2>/dev/null | awk '{print int($4)}')
    [[ -n "$boot_time" ]] && uptime_secs=$(( $(date +%s) - boot_time ))
    load_average=$(sysctl -n vm.loadavg 2>/dev/null | awk '{print $2, $3, $4}')
    memory=$(top -l 1 -s 0 2>/dev/null | awk '/PhysMem/ {print $2 " used, " $8 " unused"}')
    mount=/System/Volumes/Data
    iface=$(route -n get default 2>/dev/null | awk '/interface:/ {print $2; exit}')
    ip_addr=$(ipconfig getifaddr "$iface" 2>/dev/null)
    mac_addr=$(ifconfig "$iface" 2>/dev/null | awk '/ether/ {print $2; exit}')
    ;;
  Linux)
    # to do
    ;;
  esac

  # same on every OS, once the mount point is known
  disk=$(df -Ph "$mount" 2>/dev/null |
    awk 'NR==2 {print $2 " total, " $3 " used, " $4 " available (" $5 " used)"}')

  maus
  print_header "HOSTNAME(FQDN)"    "$host_name"
  print_header "DATE"              "$today"
  print_header "UPTIME"            "$(format_uptime "$uptime_secs")"
  print_header "LOAD AVERAGES"     "${load_average:+$load_average (1, 5, 15 min)}"
  print_header "RUNNING PROCESSES" "${procs:+$procs (total)}"
  print_header "MEMORY USAGE"      "$memory"
  print_header "DISK USAGE"        "$disk"
  print_header "IP ADDRESS"        "$ip_addr"
  print_header "MAC ADDRESS"       "$mac_addr"
}

main

###########
# Variables
###########

# Fully-qualified domain name
host_name=$(hostname -f)

# Last login
last_log=$(last | awk 'NR==1' | tr -s ' ')

# Uptime
time_up_result=$(time_up)

# Load averages (1 5 15 mins)
load_average=$(uptime | awk '{ sub(/^.*: /, ""); print; }')

# Running processes (total)
procs=$(ps ax | wc -l | tr -d " ")

# Memory usage (used, unused)
if [[ "$(uname -s)" == "Darwin" ]]; then
  mem=$(top -l 1 -s 0 | awk '/PhysMem/ {print $2,$6}')
else
  mem=$(free -h | awk 'FNR==2 {print $2, $7}')
fi

# Disk usage (size, used, avail, capacity)
if [[ "$(uname -s)" == "Darwin" ]]; then
  disk_usg=$(df -H | awk '$NF == "/" { print $2 " total, " $3 " used, " $4 " available (" $5 ")" }') 
else
  disk_usg=$(df -h --output=size,used,avail,pcent,target | 
    awk '$5 == "/" {print $1 " total, " $2 " used, " $3 " available (" $4 " used)"}')
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
printf -- '%.30s: %s\n' "${HEADR[3]}$(dot 30 .)" "${load_average} (1 5 15 min)"
printf -- '%.30s: %s\n' "${HEADR[4]}$(dot 30 .)" "${procs} (total)"
printf -- '%.30s: %s\n' "${HEADR[5]}$(dot 30 .)" "${mem} (total available)"
printf -- '%.30s: %s\n' "${HEADR[6]}$(dot 30 .)" "${disk_usg}"
printf -- '%.30s: %s\n' "${HEADR[7]}$(dot 30 .)" "${eth0}"
printf -- '%.30s: %s\n' "${HEADR[8]}$(dot 30 .)" "${macaddr}"
