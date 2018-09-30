#!/usr/bin/env bash 

HEADR=(HOSTNAME TODAY) 

host=$(hostname -f)
tdy=$(date +"%Y %B %e, %A, %T %Z")

hr() {
  # shellcheck disable=SC2183
  # print horizontal line of characters 

  printf '%*s\n' "${1:-$COLUMNS}" | tr ' ' "${2:-#}"
}

printf -- '%.30s: %s\n' "| ${HEADR[0]}$(hr 30 .)" "${host}"
printf -- '%.30s: %s\n' "| ${HEADR[1]}$(hr 30 .)" "${tdy}"

