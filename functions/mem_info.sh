#!/bin/bash 

mem_info(){

  # memory stats: used unused 
  # works in BSD not Linux; need to generalize 
  
  mem=$(top -l 1 -s 0 | awk '/PhysMem/ {print $2,$6}')
  printf "%s\\n" "$mem" 
} 

mem_info
