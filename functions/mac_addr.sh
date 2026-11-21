#!/usr/bin/env/bash
# Mac address of the default-route interface.

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

mac_address() {
  # $1: interface name, e.g. en0
  local macaddr

  case $(uname -s) in
  Darwin)
    # ifconfig for that interface: "ether" line, field 2
    macaddr=$(ifconfig "$1" 2>/dev/null | awk '/ether/ {print $2; exit}')
    ;;
  Linux)
    # kernel stores the MAC in a one-line file per interface
    macaddr=$(cat "/sys/class/net/$1/address" 2>/dev/null)
    ;;
  *)
    # unsupported OS
    ;;
  esac

  [[ -n "$macaddr" ]] && printf "%s\n" "$macaddr"
}

iface=$(default_interface)
mac_address "$iface"
