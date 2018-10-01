#!/usr/bin/env bash 

case $(uname -s) in
Darwin)
  printf "%s\\n" "Darwin"
  ;;
Linux)
  printf "%s\\n" "Linux" 
  ;;
*)
  printf "%s\\n" "He can't handle your speed, $(uname -m)"
  ;;
esac

#os_check(){
  # check if OS is LINUX or UNIX 
  # uname -s 
  # Need to check against this 
#} 
