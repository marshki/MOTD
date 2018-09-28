#!/bin/bash 

time_up(){ 
  # uptime: days hours:minutes 
  
  timeup=$(uptime | sed 's/,//g' | awk '{ print $3,$4,$5}')
  printf "%s\\n" "$timeup" 
}

time_up
