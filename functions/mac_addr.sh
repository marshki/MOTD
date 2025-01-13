#!/usr/bin/env bash
# Check OS and return primary MAC address.
  
macaddr=$(
  if [[ "$(uname -s)" == "Darwin" ]]; then
    # macOS: Get primary active interface and its MAC address
    primary_if=$(route -n get default 2>/dev/null | awk -F': ' '/interface:/ {print $2}')
    if [[ -n "$primary_if" ]]; then
      ifconfig "$primary_if" | awk '/ether/ {print $2}'
    else
      echo "Error: No primary interface found."
    fi
  else
    # Linux: Get primary active interface and its MAC address
    primary_if=$(ip route | awk '/default/ {print $5}' | head -n1)
    if [[ -n "$primary_if" ]]; then
      ip addr show "$primary_if" | awk '/ether/ {print $2}'
    else
      echo "Error: No primary interface found."
    fi
  fi
)

printf "%s\n" "$macaddr"
