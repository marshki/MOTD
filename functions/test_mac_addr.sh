#!/usr/bin/env/bash
# Detect OS
# Extract MAC address via awk.

macaddr=$(
  if [[ "$(uname -s)" == "Darwin" ]]; then
    ifconfig | awk '/ether/ {print $2; exit}'
  else
    ip link | awk '/ether/ {print $2; exit}'
  fi
)
printf "%s\n" "$macaddr"

