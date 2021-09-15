#!/usr/bin/env bash 
# load avgs. over the past 1,5,15 min. intvls.

load_averages(){ 
  # uptime, then extract string to the left of (:)
 
  load_avg=$(uptime |awk '{ sub(/^.*: /, ""); print; }')  

  printf "%s\n" "$load_avg (1, 5, 15 min)" 
}

load_averages

