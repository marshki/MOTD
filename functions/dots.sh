#!/bin/bash

dots(){ 
  # seq increments a period (".") 1-n times, where n is user defined   
  
  printf "%s" "$2"; 
  printf "%.0s." $( seq $(($1-${#2})) );
  echo; 
}

dots 30 "This" 
dots 30 "This is"
dots 30 "This is a"
dots 30 "This is a test"
dots 30 "This is also a test" 
