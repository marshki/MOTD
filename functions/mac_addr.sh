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
