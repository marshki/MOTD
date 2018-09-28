#!/bin/bash 

host_name(){
  # fully-qualified domain name 
  
  host=$(hostname -f)
  printf "%s\\n" "$host"  
}

host_name
