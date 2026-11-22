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
