#!/usr/bin/env bash
# Total # of running processes.

processes() {
  # ps all user's processes
  # wc lines, then tr to delete whitespace
  procs=$(ps ax | wc -l | tr -d " ")
  printf "%s\n" "$procs (total)"
}

processes
