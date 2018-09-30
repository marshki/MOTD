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
 
# memory stats: used unused 
# works in BSD not Linux; need to generalize 
mem=$(top -l 1 -s 0 | awk '/PhysMem/ {print $2,$6}')

# disk stats: size used avail. capacity in GBs
disk_usg=$(df -Ha | awk 'FNR == 2 {print $2,$3,$4,$5}') 

# today: year month hour minute 24-hour timezone(abbr.)
tdy=$(date +"%Y %B %e, %A, %T %Z")

maus
printf -- '%.30s: %s\n' "| ${HEADR[0]}$(hr 30 .)" "${host} (FQDN)"
printf -- '%.30s: %s\n' "| ${HEADR[1]}$(hr 30 .)" "${timeup}"
printf -- '%.30s: %s\n' "| ${HEADR[2]}$(hr 30 .)" "${last_log}"
printf -- '%.30s: %s\n' "| ${HEADR[3]}$(hr 30 .)" "${load_avg} (1 min 5 mins 15 mins)"
printf -- '%.30s: %s\n' "| ${HEADR[4]}$(hr 30 .)" "${procs} (total)"
printf -- '%.30s: %s\n' "| ${HEADR[5]}$(hr 30 .)" "${mem} (used free)"
printf -- '%.30s: %s\n' "| ${HEADR[6]}$(hr 30 .)" "${disk_usg} (size used avail capacity)"
printf -- '%.30s: %s\n' "| ${HEADR[7]}$(hr 30 .)" "${tdy}"

#printf "%s" "
#  )      |${HEADR[0]}`dots 9`: ${host} (FQDN)        
# (__     |${HEADR[1]}`dots 11`: ${timeup}
# _  )_   |${HEADR[2]}`dots 7`: ${last_log} 
#(_)_(_)  |${HEADR[3]}`dots 7`: ${load_avg} (1, 5, 15 min)  
# (o o)   |${HEADR[4]}: ${procs} (total) 
#==\o/==  |${HEADR[5]}`dots 5`: ${mem} (used unused) 
#         |${HEADR[6]}`dots 7`: ${disk_usg} (size used avail capacity) 
#         |${HEADR[7]}:`dots 11`: ${tdy}  
#" 

