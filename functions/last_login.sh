#!/usr/bin/env bash 

last_login(){ 
  # last login 
  
  last_log=$(last | awk 'NR==2'|tr -s ' ')
  printf "%s\\n" "$last_log"
} 

last_login
