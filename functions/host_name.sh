#!/usr/bin/env bash
# Fully-qualified domain name (FQDN) or hostname if FQDN not available.

host_name() {
  # FQDN or hostname 
  local host 
  host=$(hostname -f 2>/dev/null || hostname 2>/dev/null)
  [[ -n "$host" ]] && printf "%s\n" "$host"
}

host_name
