#!/usr/bin/env/bash
# Detect OS and extract MAC address.

case $(uname -s) in
Darwin)
  # awk to extract 'ether' and print 2nd column
  macaddr=$(ifconfig | awk '/ether/ {print $2; exit}')
  printf "%s\n" "$macaddr"
  ;;
Linux)
  # awk to extract 'ether' and print 2nd column
  macaddr=$(ip link | awk '/ether/ {print $2; exit}')
  printf "%s\n" "$macaddr"
  ;;
*)
  printf "%s\n" "He can't handle your speed, $(uname -s)"
  ;;
esac
