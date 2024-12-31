#!/usr/bin/env bash
# Fully-qualified domain name (FQDN).

host_name() {
  # FQDN
  host=$(hostname -f)
  printf "%s\\n" "$host (FQDN)"
}

host_name
