#!/usr/bin/env bash
# Total no. of running processes.

process_count() {
  local procs

  # ps to list all processes, showing only process ID column
  # wc lines, then tr to delete whitespace
  procs=$(ps -A -o pid= 2>/dev/null | wc -l | tr -d " ")
  printf "%s\n" "$procs (total)"
}

process_count
