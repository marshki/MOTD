#!/bin/bash 

mem_info(){

  # memory stats: used unused 
  # works in BSD not Linux; need to generalize 
  
  mem=$(top -l 1 -s 0 | awk '/PhysMem/ {print $2,$6}')
  printf "%s\\n" "$mem (used unused)" 
} 

mem_info

mem_info(){

  # memory stats: used unused 
  # works in BSD not Linux; need to generalize 
  
  mem=$(free |awk 'FNR==2 {print $3, $4}')
  printf "%s\\n" "$mem (used unused)"
} 

mem_info
