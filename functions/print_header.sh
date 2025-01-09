#!/usr/bin/env bash
# Print the MOTD header with appropriate values.

dot() {
  printf '%*s\n' "${1:-$COLUMNS}" | tr ' ' "${2:-#}"
}

print_header() {
  local title=$1
  local value=$2
  printf -- '%.30s: %s\n' "${title}$(dot 30 .)" "${value}"
}

print_header
