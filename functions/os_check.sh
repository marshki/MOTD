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
# host=$(hostname -f)

host_name(){
  # fully-qualified domain name 
  
  host=$(hostname -f)
  printf "%s\\n" "$host (FQDN)"  
}

addr_o(){
  # get MACADDR for primary
  # OS X

  mac=$(ifconfig en1 | awk '/ether/{print $2}')
  printf "%s\\n" "$mac"
}

addr_l(){
  # get MACADDR for primary
  # Linux

  mac=$(cat /sys/class/net/eth0/address)
  printf "%s\\n" "$mac"
}


#mac_osx=$(ifconfig en1 | awk '/ether/{print $2}')
#mac=$(cat /sys/class/net/eth0/address)
  
case $(uname -s) in
Darwin)
  maus
  printf "%s\\n" "Darwin"
  printf -- '%.30s: %s\n' "| ${HEADR[0]}$(hr 30 .)" host_name"#"${host} (FQDN)"
  printf -- '%.30s: %s\n' "| ${HEADR[1]}$(hr 30 .)" addr_o"#"${mac_osx}"
  ;;
Linux)
  printf "%s\\n" "Linux" 
  maus
  printf -- '%.30s: %s\n' "| ${HEADR[0]}$(hr 30 .)" host_name"#"${host} (FQDN)"
  printf -- '%.30s: %s\n' "| ${HEADR[1]}$(hr 30 .)" addr_l"#"${mac}"
  ;;
*)
  printf "%s\\n" "He can't handle your speed, $(uname -m)"
  ;;
esac

#os_check(){
  # check if OS is LINUX or UNIX 
  # uname -s 
  # Need to check against this 
#} 
