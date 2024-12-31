#!/usr/bin/env bash
# print horizontal line of x characters y times,
# in this case a 'dot'.

dot() {
  # shellcheck disable=SC2183
  # print (#) to column width
  # print (.) to column position 30
  printf '%*s\n' "${1:-$COLUMNS}" | tr ' ' "${2:-#}"
}

printf -- '%.30s: %s\n' "| $(dot 30 .)"
