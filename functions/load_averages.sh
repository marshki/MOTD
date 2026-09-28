#!/usr/bin/env bash
# CPU load averages over the past 1, 5, and 15 minute intervals.

load_averages() { 
  local load_average

  case $(uname -s) in
  Darwin)
    # awk to parse fields 2, 3, 4 from vm.loadavg
    load_average=$(sysctl -n vm.loadavg 2>/dev/null | awk '{print $2, $3, $4}')
  ;;
  Linux)
    # awk to parse fields 1, 2, 3 from /proc/loadavg 
    load_average=$(awk '{print $1, $2, $3}' /proc/loadavg 2>/dev/null)
  ;;
  *)
    # unsupported OS
   ;;
  esac
  [[ -n "$load_average" ]] && printf "%s\n" "$load_average (1, 5, 15 min)"
}

load_averages
