#!/bin/bash 

host_name(){
  # fully-qualified domain name 
  
  host=$(hostname -f)
  printf "%s\\n" "$host (FQDN)"  
}

host_name
