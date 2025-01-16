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

time_up
