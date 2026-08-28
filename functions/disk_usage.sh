#!/usr/bin/env bash
# disk stats: total used avail. capacity in GBs

disk_usage() {
  # awk second row, then take columns 2-5 inclusive
  disk_usg=$(df -H | awk '$NF == "/" { print $2 " total, " $3 " used, " $4 " available (" $5 ")" }') 
  printf "%s\\n" "$disk_usg"
}

disk_usage
