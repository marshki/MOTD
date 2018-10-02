#!/usr/bin/env bash 
  
case $(uname -s) in

Darwin)
  
  # memory stats: used unused
  mem=$(top -l 1 -s 0 | awk '/PhysMem/ {print $2,$6}')
  
  printf "%s\\n" "$mem (used unused)" 
  ;;

Linux)
  
  # memory stats: used unused 
  mem=$(free |awk 'FNR==2 {print $3, $4}')
  
  printf "%s\\n" "$mem (used unused)"
  ;;

*)
  printf "%s\\n" "He can't handle your speed, $(uname -s)"
  ;;
esac

