#!/usr/bin/env bash 
# Check OS; return primary IP 
  
case $(uname -s) in
Darwin)
  
  # get IP address for eth0 (primary) in OS X 
  eth0=$(ipconfig getifaddr en0) 

  printf "%s\\n" "$eth0"
  ;;

Linux)

  # get IP address for eth0 (primary) in Linux 
  eth0=$(ip route get 1 | awk '{print $NF;exit}')

  printf "%s\\n" "$eth0"

  ;;

*)
  printf "%s\\n" "He can't handle your speed, $(uname -s)"
  ;;
esac

