#!/usr/bin/env bash 
# Check OS; return free and used memory based on result 
  
case $(uname -s) in

Darwin)
  
  # memory stats: used unused
  # top sample once, delay 0 secs
  # awk regex, return columns 2,6
  # --> KiB is returned in truncated format, which can throw off results <--

  memory=$(top -l 1 -s 0 | awk '/PhysMem/ {print $2,$6}')
  
  printf "%s\n" "$memory (used unused)" 
  ;;

Linux)
  
  # memory stats: used unused 
  # free, then awk second row, print columns 3,4

  memory=$(free -g |awk 'FNR==2 {print $3, $4}')

  #-->work on this, need to print the proper row and columns <<- 
  #memory=$(top -n 1 -d 0 |awk '/Mem/ {print $8, $6}' |head -1) 
  
  printf "%s\n" "$memory (used unused)"
  ;;

*)
  printf "%s\n" "He can't handle your speed, $(uname -s)"
  ;;
esac
