#!/usr/bin/env bash
# Disk usage: total, used, available, percent used.

disk_usage() {
  local mount disk_usg

  case $(uname -s) in
  Darwin)
    # user files live on the Data volume, not /
    mount=/System/Volumes/Data
    ;;
  Linux)
    mount=/
    ;;
  *)
    # unsupported OS
    ;;
  esac

  # -P: one line per filesystem; -h: human-readable sizes
  # line 2, fields 2-5: size, used, available, percent
  [[ -n "$mount" ]] && disk_usg=$(df -Ph "$mount" 2>/dev/null |
    awk 'NR==2 {print $2 " total, " $3 " used, " $4 " available (" $5 " used)"}')

  [[ -n "$disk_usg" ]] && printf "%s\n" "$disk_usg"
}

disk_usage
