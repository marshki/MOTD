#!/usr/bin/env bash
# Check OS and return primary MAC address.
  
macaddr=$(
  if [[ "$(uname -s)" == "Darwin" ]]; then
    route -n get default 2>/dev/null | awk -F': ' '/interface:/ {print $2}' | \
      xargs ifconfig | awk '/ether/ {print $2}'
  else
    ip route | awk '/default/ {print $5}' | \
      xargs ip addr show | awk '/ether/ {print $2}'
    fi
)

printf "%s\n" "$macaddr"
