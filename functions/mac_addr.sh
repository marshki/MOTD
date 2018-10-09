#!/usr/bin/env bash 
# Check OS; return primary MAC 
  
case $(uname -s) in
Darwin)

  # get MACADDR for primary in OS X  
  # get mac addr for en1, 
  # then regex for ether, print 2nd column

  mac=$(ifconfig en1 | awk '/ether/{print $2}')

  printf "%s\\n" "$mac"
  ;;

Linux)
  
  # get MACADDR for primary in Linux  

  mac=$(cat /sys/class/net/eth0/address)
  
  printf "%s\\n" "$mac"
  ;;

*)
  printf "%s\\n" "He can't handle your speed, $(uname -s)"
  ;;
esac

