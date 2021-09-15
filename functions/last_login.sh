#!/usr/bin/env bash

last_login(){
  # last login
  # print second line of last command
  # strip out sequence of repeated characters (' ', i.e. whitespace)
 
  last_log=$(last | awk 'NR==2'|tr -s ' ')

  printf "%s\\n" "$last_log"
}

last_login
