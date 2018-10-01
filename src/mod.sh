#!/bin/bash 
# mjk 2018.09.28 

# header array 
HEADR=(HOSTNAME UPTIME "LAST LOGIN" "LOAD AVGS." "RUNNING PROCESSES" "MEMORY USAGE" "DISK USAGE" "TODAY")

hr() {
  # shellcheck disable=SC2183
  # print horizontal line of characters 

  printf '%*s\n' "${1:-$COLUMNS}" | tr ' ' "${2:-#}"
}

maus(){
  # ASCII mouse 
  # NEED TO CENTER; ADD DIALOG

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
  
# uptime: days hours:minutes 
timeup=$(uptime | sed 's/,//g' | awk '{ print $3,$4,$5}')

# last login 
last_log=$(last | awk 'NR==2'|tr -s ' ')
 
# load avgs. over the past 1,5,15 min. intvls. 
load_avg=$(uptime | awk -F'[a-z]:' '{print $2}') 
 
# running processes
procs=$(ps ax | wc -l | tr -d " ")
 
# disk stats: size used avail. capacity in GBs
disk_usg=$(df -Ha | awk 'FNR == 2 {print $2,$3,$4,$5}') 

# today: year month hour minute 24-hour timezone(abbr.)
tdy=$(date +"%Y %B %e, %A, %T %Z")


case $(uname -s) in

Darwin)
  # MAC address 
  mac_osx=$(ifconfig en1 | awk '/ether/{print $2}')

  # IP address 
  eth0=$(ipconfig getifaddr en0)

  # Memory free/used
  mem=$(top -l 1 -s 0 | awk '/PhysMem/ {print $2,$6}')

  maus
  printf "%s\\n" "Darwin"
  printf -- '%.30s: %s\n' "| ${HEADR[0]}$(hr 30 .)" "${host} (FQDN)"
  printf -- '%.30s: %s\n' "| ${HEADR[1]}$(hr 30 .)" "${timeup}"
  printf -- '%.30s: %s\n' "| ${HEADR[2]}$(hr 30 .)" "${last_log}"
  printf -- '%.30s: %s\n' "| ${HEADR[3]}$(hr 30 .)" "${load_avg} (1 min 5 mins 15 mins)"
  printf -- '%.30s: %s\n' "| ${HEADR[4]}$(hr 30 .)" "${procs} (total)"
  printf -- '%.30s: %s\n' "| ${HEADR[5]}$(hr 30 .)" "${mem} (used unused)"
  printf -- '%.30s: %s\n' "| ${HEADR[6]}$(hr 30 .)" "${disk_usg} (size used avail capacity)"
  printf -- '%.30s: %s\n' "| ${HEADR[7]}$(hr 30 .)" "${tdy}"
  ;;

Linux)
  # MAC ADDRESS
  mac=$(cat /sys/class/net/eth0/address)
 
  # Memory free/used
  mem=$(free |awk 'FNR==2 {print $3, $4}') 

  maus
  printf "%s\\n" "Linux" 
  printf -- '%.30s: %s\n' "| ${HEADR[0]}$(hr 30 .)" "${host} (FQDN)"
  printf -- '%.30s: %s\n' "| ${HEADR[1]}$(hr 30 .)" "${timeup}"
  printf -- '%.30s: %s\n' "| ${HEADR[2]}$(hr 30 .)" "${last_log}"
  printf -- '%.30s: %s\n' "| ${HEADR[3]}$(hr 30 .)" "${load_avg} (1 min 5 mins 15 mins)"
  printf -- '%.30s: %s\n' "| ${HEADR[4]}$(hr 30 .)" "${procs} (total)"
  printf -- '%.30s: %s\n' "| ${HEADR[5]}$(hr 30 .)" "${mem} (used unused)"
  printf -- '%.30s: %s\n' "| ${HEADR[6]}$(hr 30 .)" "${disk_usg} (size used avail capacity)"
  printf -- '%.30s: %s\n' "| ${HEADR[7]}$(hr 30 .)" "${tdy}"
  ;;

*)
  printf "%s\\n" "He can't handle your speed, $(uname -m)"
  ;;
esac



#maus
#printf -- '%.30s: %s\n' "| ${HEADR[0]}$(hr 30 .)" "${host} (FQDN)"
#printf -- '%.30s: %s\n' "| ${HEADR[1]}$(hr 30 .)" "${timeup}"
#printf -- '%.30s: %s\n' "| ${HEADR[2]}$(hr 30 .)" "${last_log}"
#printf -- '%.30s: %s\n' "| ${HEADR[3]}$(hr 30 .)" "${load_avg} (1 min 5 mins 15 mins)"
#printf -- '%.30s: %s\n' "| ${HEADR[4]}$(hr 30 .)" "${procs} (total)"
#printf -- '%.30s: %s\n' "| ${HEADR[5]}$(hr 30 .)" "${mem} (used unused)"
#printf -- '%.30s: %s\n' "| ${HEADR[6]}$(hr 30 .)" "${disk_usg} (size used avail capacity)"
#printf -- '%.30s: %s\n' "| ${HEADR[7]}$(hr 30 .)" "${tdy}"


