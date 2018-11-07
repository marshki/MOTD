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
  # probe all in ifconfig, 
  # grep for 1st match, then perl regular expressions to print content after HWaddr string 

  mac=$(ifconfig -a | grep -m1 --perl-regexp --only-matching 'HWaddr \K.*$)  
  
  printf "%s\\n" "$mac"
  ;;

*)
  printf "%s\\n" "He can't handle your speed, $(uname -s)"
  ;;
esac

