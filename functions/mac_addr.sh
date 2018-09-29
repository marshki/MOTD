#!/bin/bash 

mac_addr(){
  # get MACADDR for primary  
  # OS X 
 
  mac=$(ifconfig en1 | awk '/ether/{print $2}')
  printf "%s\\n" "$mac"
} 
mac_addr 

mac_addr(){
  # get MACADDR for primary  
  # Linux  
 
  mac=$(cat /sys/class/net/eth0/address)
  printf "%s\\n" "$mac"
} 

mac_addr

