#!/usr/bin/env bash 
# Check OS; return free and used memory based on result. 
  
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

  # Sample outputs:
  # MiB Mem :   7661.1 total,   2233.0 free,   2893.5 used,   2534.6 buff/cache
  # KiB Mem :  1698324 total,   711904 free,   419296 used,   567124 buff/cache
  # Mem:  132149488k total,  3042460k used, 129107028k free,   957356k buffers
  # KiB Mem : 13201608+total, 12153704+free,  2608656 used,  7870376 buff/cache
  # KiB Mem : 11550142+total, 10699744+free,  2259544 used,  6244432 buff/cache

  # Extract using this: 
  # top -n 1 -d 0 | awk '/Mem/'
  # top -n 1 -d 0 | awk 'NR==4'
  
  printf "%s\n" "$memory (used unused)"
  ;;

*)
  printf "%s\n" "He can't handle your speed, $(uname -s)"
  ;;
esac
