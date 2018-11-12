#!/usr/bin/env bash 
# Check OS; return free and used memory based on result 
  
case $(uname -s) in

Darwin)
  
  # memory stats: used unused
  # top sample once, delay 0 secs
  # awk regex, return columns 2,6

  mem=$(top -l 1 -s 0 | awk '/PhysMem/ {print $2,$6}')
  
  printf "%s\\n" "$mem (used unused)" 
  ;;

Linux)
  
  # memory stats: used unused 
  # free, then awk second row, print columns 3,4

  mem=$(free |awk 'FNR==2 {print $3, $4}')

  #mem=$(free -m |awk 'FNR==2 {print $3, $4}')

  #-->work on this, need to print the proper row and columns <<- 
  #top -n 1 -d 0 |awk '/Mem/ {print $6,$8}' |head -1
  
  printf "%s\\n" "$mem (used unused)"
  ;;

*)
  printf "%s\\n" "He can't handle your speed, $(uname -s)"
  ;;
esac
