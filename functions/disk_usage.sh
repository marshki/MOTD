#!/usr/bin/env bash
# disk stats: size used avail. capacity in GBs

disk_usage() {
  # awk second row, then take columns 2-5 inclusive
  disk_usg=$(df -Ha | awk 'FNR == 2 {print $2,$3,$4,$5}')
  printf "%s\\n" "$disk_usg (size used avail capacity)"
}

disk_usage
