#!/usr/bin/env bash
# CPU load averages over the past 1, 5, 15 min. intervals.

load_averages() {
  # uptime, then strip everything to the left of (:)
  load_average=$(uptime |awk '{ sub(/^.*: /, ""); print; }')
  printf "%s\n" "$load_average (1, 5, 15 min)"
}

load_averages
