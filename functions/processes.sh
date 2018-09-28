#!/bin/bash 

processes(){ 
  # running processes

  procs=$(ps ax | wc -l | tr -d " ")
  printf "%s\\n" "$procs (total)" 
} 

processes
