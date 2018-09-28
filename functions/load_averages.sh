#!/bin/bash 

load_averages(){ 
  # load avgs. over the past 1,5,15 min. intvls.

  load_avg=$(uptime | awk -F'[a-z]:' '{print $2}') 
  printf "%s\\n" "$load_avg (1, 5, 15 min)" 
}

load_averages

