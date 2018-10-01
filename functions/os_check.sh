#!/usr/bin/env bash 

#Header array 
HEADR=(HOSTNAME "MAC ADDRESS")  

hr(){
  # shellcheck disable=SC2183
  # print horizontal line of characters 

  printf '%*s\n' "${1:-$COLUMNS}" | tr ' ' "${2:-#}"
}

maus() {
  # ASCII mouse 

printf '
  )            
 (__
 _  )_
(_)_(_)
 (o o)
==\o/==
'
}

# fully-qualified domain name 
host=$(hostname -f)

  
case $(uname -s) in
Darwin)
  # MAC ADDRESS
  mac_osx=$(ifconfig en1 | awk '/ether/{print $2}')

  maus
  printf "%s\\n" "Darwin"
  printf -- '%.30s: %s\n' "| ${HEADR[0]}$(hr 30 .)" "${host} (FQDN)" 
  printf -- '%.30s: %s\n' "| ${HEADR[1]}$(hr 30 .)" "${mac_osx}"
  ;;
Linux)
  # MAC ADDRESS
  mac=$(cat /sys/class/net/eth0/address)
  
  maus
  printf "%s\\n" "Linux" 
  printf -- '%.30s: %s\n' "| ${HEADR[0]}$(hr 30 .)" "${host} (FQDN)"
  printf -- '%.30s: %s\n' "| ${HEADR[1]}$(hr 30 .)" "${mac}" 
  ;;
*)
  printf "%s\\n" "He can't handle your speed, $(uname -m)"
  ;;
esac

