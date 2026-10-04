#!/usr/bin/env bash
# Total no. of running processes.

process_count() {
  # ps to list allprocesses, showing only process ID column
  # wc lines, then tr to delete whitespace
  procs=$(ps -A -o pid= | wc -l | tr -d " ")
  printf "%s\n" "$procs (total)"
}

process_count
