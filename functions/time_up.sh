#!/usr/bin/env bash
# Uptime: days hours:minutes
# e.g.: "1 day, HH:MM" or: "HH:MM".

time_up() {
  # uptime
  # sed to stip commas
  # awk to print columns (depending on if uptime is days or hours)
  local uptime_info=$(uptime | sed 's/,//g')
  if [[ "$uptime_info" == *"day"* ]]; then
    printf "%s\n" "$uptime_info" | awk '{ print $3, $4, $5 }'
  else
    printf "%s\n" "$uptime_info" | awk '{ print $3 }'
  fi
}

time_up
