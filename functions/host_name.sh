#!/usr/bin/env bash 
# Check OS; return free and used memory based on result 

host_name(){
  # fully-qualified domain name 
  
  host=$(hostname -f)

  printf "%s\\n" "$host (FQDN)"  
}

host_name
