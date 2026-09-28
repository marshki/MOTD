#!/usr/bin/env bash
# Uptime: days hours:minutes
# e.g.: "1 day, HH:MM" or: "HH:MM".

uptime_seconds() {
  local uptime_secs
  case $(uname -s) in
    Darwin)
      # awk to parse field 4, as an integer, from kern.boottime
      boot_time=$(sysctl -n kern.boottime | awk '{print int($4)}')
      current_time=$(date +%s)
      boot_time=$((current_time - boot_time))
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

uptime_seconds
