#!/usr/bin/env bash 
# Today: date command formatted as: 
# year month hour minute 24-hour timezone(abbr.)

today(){
    
  tdy=$(date +"%Y %B %e, %A, %T %Z")
  printf "%s \n" "$tdy" 
} 

today
