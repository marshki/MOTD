#!/usr/bin/env bash
# Check OS; return primary MAC address.
  
case $(uname -s) in
Darwin)
  # get MACADDR for primary in macOS
  # get mac addr for en0,
  # then regex for ether, print 2nd column
  mac=$(ifconfig en0 | awk '/ether/{print $2}')
  printf "%s\n" "$mac"
  ;;
Linux)
  # get MACADDR for primary in GNU/Linux
  # ip addr for eth0, then awk to match ether and extract
  mac=$(ip addr show eth0 |awk '/ether/{print $2}')
  printf "%s\n" "$mac"
  ;;
*)
  printf "%s\n" "He can't handle your speed, $(uname -s)"
  ;;
esac


# Alternative approach
# GNU/Linux
ip link | awk '/ether/ {print $2; exit}'
# macOS
ifconfig | awk '/ether/ {print $2; exit}'
