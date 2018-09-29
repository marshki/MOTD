#!/bin/bash 

eth0_ip(){
  # get IP address for eth0 (primary)
  # OS X 
 
  eth0=$(ipconfig getifaddr en0)
  printf "%s\\n" "$eth0"
} 


eth0_ip 

eth0_ip(){
  # get IP address for eth0 (primary)
  # Linux 
 
  eth0=$(ip route get 1 | awk '{print $NF;exit}')
  printf "%s\\n" "$eth0"
} 

eth0_ip
