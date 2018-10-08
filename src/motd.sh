#!/usr/bin/env bash 
# mjk 2018.09.28 

# Message of the day (MOD) for BSD & Linux
# 



#### HEADER ARRAY ####

HEADR=("HOSTNAME(FQDN)" TODAY "LAST LOGIN" UPTIME "LOAD AVGS." "RUNNING PROCESSES" "MEMORY USAGE" "DISK USAGE" "IP ADDRESS" "MAC ADDRESS")

#### ####

# fully-qualified domain name 
host_name=$(hostname -f)

# today: year month hour minute 24-hour timezone(abbr.)
tdy=$(date +"%Y %B %e, %A, %T %Z")

# last login 
last_log=$(last | awk 'NR==2'|tr -s ' ')

# uptime: days hours:minutes 
time_up=$(uptime | sed 's/,//g' | awk '{ print $3,$4,$5}')
 
# load avgs. over the past 1,5,15 min. intvls. 
load_avg=$(uptime | awk -F'[a-z]:' '{print $2}') 
 
# running processes
procs=$(ps ax | wc -l | tr -d " ")
 
# disk stats: size used avail. capacity in GBs
disk_usg=$(df -Ha | awk 'FNR == 2 {print $2,$3,$4,$5}') 

#### ASCII ART ####
maus() {
  # ASCII mouse w/text box, centered 

printf '
                             )            
                            (__        ---------------
                            _  )_     < PSYCH//CNS TEK >
                           (_)_(_)     --------------- 
                            (o o)  _ _/
                           ==\o/== 
'
} 

#### #### 

hr(){
  # shellcheck disable=SC2183
  # print horizontal line of characters 

  printf '%*s\n' "${1:-$COLUMNS}" | tr ' ' "${2:-#}"
}

#### Meat & Potatoes ####

case $(uname -s) in

Darwin)
  # Memory free/used
  mem=$(top -l 1 -s 0 | awk '/PhysMem/ {print $2,$6}')

  # IP address 
  eth0=$(ipconfig getifaddr en0)

  # MAC address 
  macaddr=$(ifconfig en1 | awk '/ether/{print $2}')
  
  maus
  
  printf -- '%.30s: %s\n' "| ${HEADR[0]}$(hr 30 .)" "${host_name}" 
  printf -- '%.30s: %s\n' "| ${HEADR[1]}$(hr 30 .)" "${tdy}" 
  printf -- '%.30s: %s\n' "| ${HEADR[2]}$(hr 30 .)" "${last_log}"
  printf -- '%.30s: %s\n' "| ${HEADR[3]}$(hr 30 .)" "${time_up}"
  printf -- '%.30s: %s\n' "| ${HEADR[4]}$(hr 30 .)" "${load_avg} (1 min 5 mins 15 mins)"
  printf -- '%.30s: %s\n' "| ${HEADR[5]}$(hr 30 .)" "${procs} (total)"
  printf -- '%.30s: %s\n' "| ${HEADR[6]}$(hr 30 .)" "${mem} (used unused)"
  printf -- '%.30s: %s\n' "| ${HEADR[7]}$(hr 30 .)" "${disk_usg} (size used avail capacity)"
  printf -- '%.30s: %s\n' "| ${HEADR[8]}$(hr 30 .)" "${eth0}" 
  printf -- '%.30s: %s\n' "| ${HEADR[9]}$(hr 30 .)" "${macaddr}" 
;;

Linux)
  # Memory free/used
  mem=$(free |awk 'FNR==2 {print $3, $4}') 
 
  # get IP address for eth0 (primary) 
  eth0=$(ip route get 1 | awk '{print $NF;exit}')
 
  # MAC ADDRESS
  macaddr=$(cat /sys/class/net/eth0/address)
 
  maus

  printf -- '%.30s: %s\n' "| ${HEADR[0]}$(hr 30 .)" "${host_name}" 
  printf -- '%.30s: %s\n' "| ${HEADR[1]}$(hr 30 .)" "${tdy}" 
  printf -- '%.30s: %s\n' "| ${HEADR[2]}$(hr 30 .)" "${last_log}"
  printf -- '%.30s: %s\n' "| ${HEADR[3]}$(hr 30 .)" "${time_up}"
  printf -- '%.30s: %s\n' "| ${HEADR[4]}$(hr 30 .)" "${load_avg} (1 min 5 mins 15 mins)"
  printf -- '%.30s: %s\n' "| ${HEADR[5]}$(hr 30 .)" "${procs} (total)"
  printf -- '%.30s: %s\n' "| ${HEADR[6]}$(hr 30 .)" "${mem} (used unused)"
  printf -- '%.30s: %s\n' "| ${HEADR[7]}$(hr 30 .)" "${disk_usg} (size used avail capacity)"
  printf -- '%.30s: %s\n' "| ${HEADR[8]}$(hr 30 .)" "${eth0}" 
  printf -- '%.30s: %s\n' "| ${HEADR[9]}$(hr 30 .)" "${macaddr}" 

   ;;

*)
  printf "%s\\n" "He can't handle your speed, $(uname -s)"
  ;;
esac
