#!/usr/bin/env bash 
# Check OS; return free and used memory based on result. 
  
case $(uname -s) in

Darwin)
  
  # memory stats: used unused
  # top sample once, delay 0 secs
  # awk regex, return columns 2,6
  # --> KiB is returned in truncated format, which can throw off results <--

  memory=$(top -l 1 -s 0 | awk '/PhysMem/ {print $2,$6}')
  
  printf "%s\n" "$memory (total unused)" 
  ;;

Linux)
  
  # memory stats: used unused 
  # free, then awk second row, print columns 3,4

  memory=$(free -g |awk 'FNR==2 {print $2, $4}')

  printf "%s\n" "$memory (total unused)"
  ;;

*)
  printf "%s\n" "He can't handle your speed, $(uname -s)"
  ;;
esac
