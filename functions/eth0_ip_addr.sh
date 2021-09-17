#!/usr/bin/env bash
# Check OS; return primary IP.
  
case $(uname -s) in
Darwin)
  
  # get IP address for eth0 (primary) in macOS. 
  eth0=$(ipconfig getifaddr en0)

  printf "%s\n" "$eth0"
  ;;

Linux)

  # get IP address for eth0 (primary) in Linux.
  # ip add for eth0, then print last column.

  eth0=$(ip route get 1 | awk '{print $NF;exit}')
  
  # Simpler, but need to test:
  # hostname -I |awk '{printf $1}'

  printf "%s\n" "$eth0"

  ;;

*)
  printf "%s\n" "He can't handle your speed, $(uname -s)"
  ;;
esac

