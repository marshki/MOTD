#!/usr/bin/env bash
# uptime: days hours:minutes

time_up() {
  # uptime
  # strip commas, then print columns 3,4,5
  timeup=$(uptime | sed 's/,//g' | awk '{ print $3,$4,$5}')
  printf "%s\n" "$timeup"
}

time_up
