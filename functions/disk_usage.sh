#!/usr/bin/env bash
# disk stats: total used available %capacity in GBs

disk_usage() {
  # awk second row, then take columns 2-5 inclusive
  disk_usg=$(df -h --output=size,used,avail,pcent,target |
    awk '$5 == "/" {print $1 " total, " $2 " used, " $3 " available (" $4 " used)"}')
  printf "%s\n" "$disk_usg"
}

disk_usage
