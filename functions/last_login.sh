#!/usr/bin/env bash
# Last logged in user.

last_login() {
  # print first line of last command
  # strip out sequence of repeated characters (' ', i.e. whitespace)
  last_log=$(last | awk 'NR==1'|tr -s ' ')
  printf "%s\n" "$last_log"
}

last_login
