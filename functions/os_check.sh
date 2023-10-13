#!/usr/bin/env bash 
# detect system architecture, then act
  
case $(uname -s) in
Darwin)

  printf "%s\n" "Darwin"
  ;;
Linux)

  printf "%s\n" "Linux" 
  ;;
*)

  printf "%s\n" "He can't handle your speed, $(uname -s)"
  ;;
esac
