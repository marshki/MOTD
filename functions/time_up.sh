#!/usr/bin/env bash
# Uptime: days hours:minutes
# e.g.: "1 day, HH:MM" or: "HH:MM".

uptime_seconds() {
  local uptime_secs boot_time current_time

  case $(uname -s) in
    Darwin)
      # awk to parse field 4, as an integer, from kern.boottime
      boot_time=$(sysctl -n kern.boottime 2>/dev/null | awk '{print int($4)}')
      current_time=$(date +%s)
      [[ -n "$boot_time" ]] && uptime_secs=$((current_time - boot_time))
    ;;
    Linux)
      # awk to parse field 1, as an integer, from /proc/uptime
      uptime_secs=$(awk '{print int($1)}' /proc/uptime 2>/dev/null)
    ;;
    *)
      # unsupported OS
     ;;
  esac

  [[ -n "$uptime_secs" ]] && printf "%s\n" "$uptime_secs"
}

format_uptime() {
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

format_uptime 90061
