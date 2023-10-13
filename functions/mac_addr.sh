#!/usr/bin/env bash
# Check OS; return primary MAC
  
case $(uname -s) in
Darwin)

  # get MACADDR for primary in OS X  
  # get mac addr for en0, 
  # then regex for ether, print 2nd column

  mac=$(ifconfig en0 | awk '/ether/{print $2}')

  printf "%s\\n" "$mac"
  ;;

Linux)
  
  # get MACADDR for primary in Linux 
  # ip addr for eth0, then awk to match ether and extract

  mac=$(ip addr show eth0 |awk '/ether/{print $2}')
  
  printf "%s\\n" "$mac"
  ;;

*)
  printf "%s\\n" "He can't handle your speed, $(uname -s)"
  ;;
esac

