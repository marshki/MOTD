#!/usr/bin/env bash
# Memory usage (used and unused).
  
memory_usage() { 
  local memory

  case $(uname -s) in
  Darwin)
  # top: sample once, no delay; PhysMem line, field 2 (used)
  memory=$(top -l 1 -s 0 2>/dev/null |
    awk '/PhysMem/ {print $2 " used, " $8 " unused"}')
  ;;
Linux)
  # free: second line (Mem:), fields 3 (used) and 4 (free)
  memory=$(free --human 2>/dev/null |
    awk 'FNR==2 {print $3 " used, " $4 " unused"}')
  ;;
*)
  # unsupported OS
  ;;
esac
}
