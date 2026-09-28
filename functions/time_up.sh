#!/usr/bin/env bash
# Uptime: days hours:minutes
# e.g.: "1 day, HH:MM" or: "HH:MM".

time_up() {
  # uptime 
  # sed to strip commas 
  # awk to handle both 'day' and non-'day' cases
  local uptime_info
  uptime_info=$(uptime | sed 's/,//g')

  printf "%s\n" "$uptime_info" | awk '
    / day/ { print $3, $4, $5 }
    !/ day/ { print $3 }
  '
}

# time_up

uptime_seconds() {

  case $(uname -s) in
    Darwin)
      # awk to parse field 1, as an integer, from kern.boottime
      boot_time=$(sysctl -n kern.boottime | awk '{print int($4)}')
    ;;
    Linux)
      # awk to parse field 1, as an integer, from /proc/uptime 
      boot_time=$(awk '{print int($1)}' /proc/uptime)
    ;;
    *)
      # unsupported OS
     ;;
  esac
}

current_time=$(date +%s)
echo $((current_time - boot_time))

