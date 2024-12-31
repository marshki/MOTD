#!/usr/bin/env bash
# Check OS and return primary IP.
  
case $(uname -s) in
Darwin)
  # get IP address for eth0 (primary) in macOS
  eth0=$(ipconfig getifaddr en0)
  printf "%s\n" "$eth0"
  ;;
Linux)
  # get IP address for eth0 (primary) in GNU/Linux
  hostname --all-ip-addresses |awk '{printf $1}'
  printf "%s\n" "$eth0"
  ;;
*)
  printf "%s\n" "He can't handle your speed, $(uname -s)"
  ;;
esac
