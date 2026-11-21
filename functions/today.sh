#!/usr/bin/env bash
# Current date and time, e.g.: Saturday, November 21, 2026 13:53 EST

today() {
  local now

  # same format codes on macOS and Linux, so no case needed
  now=$(date +"%A, %B %d, %Y %H:%M %Z")

  printf "%s \n" "$now"
}

today
