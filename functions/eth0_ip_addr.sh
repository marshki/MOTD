#!/usr/bin/env bash
# Primary IPv4 address: the IP of the default-route interface.

default_interface() {
  local iface

  case $(uname -s) in
  Darwin)
    # route: "interface: <name>" line, field 2
    iface=$(route -n get default 2>/dev/null |
      awk '/interface:/ {print $2; exit}')
    ;;
  Linux)
    # ip route: "default via <gateway> dev <interface> ...", field 5
    iface=$(ip route show default 2>/dev/null |
      awk '{print $5; exit}')
    ;;
  *)
    # unsupported OS
    ;;
  esac

  [[ -n "$iface" ]] && printf "%s\n" "$iface"
}

ip_address() {
  # $1: interface name, e.g. en0
  local ip_addr

  case $(uname -s) in
  Darwin)
    ip_addr=$(ipconfig getifaddr "$1" 2>/dev/null)
    ;;
  Linux)
    # "inet 172.22.114.85/24 ..." line: field 2, then drop the /24
    ip_addr=$(ip -4 addr show dev "$1" 2>/dev/null |
      awk '/inet / {print $2; exit}' | cut -d/ -f1)
    ;;
  *)
    # unsupported OS
    ;;
  esac

  [[ -n "$ip_addr" ]] && printf "%s\n" "$ip_addr"
}

iface=$(default_interface)
ip_address "$iface"
