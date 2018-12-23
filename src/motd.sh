#!/usr/bin/env bash 
# mjk 2018.09.28 
# Message of the day (MOTD) for BSD & Linux

#### HEADER ARRAY ####

HEADR=("HOSTNAME(FQDN)" "LAST LOGIN" UPTIME "LOAD AVGS." "RUNNING PROCESSES" "MEMORY USAGE" "DISK USAGE" "IP ADDRESS" "MAC ADDRESS")

#### VARIABLES ####

# fully-qualified domain name 
host_name=$(hostname -f)

# last login 
last_log=$(last | awk 'NR==1'|tr -s ' ')

# uptime: days hours:minutes 
time_up=$(uptime | sed 's/,//g' | awk '{ print $3,$4,$5}') 

# load avgs. over the past 1,5,15 min. intvls. 
load_avg=$(uptime |awk '{ sub(/^.*: /, ""); print; }') 
 
# running processes
procs=$(ps ax | wc -l | tr -d " ")
 
# disk stats: size used avail. capacity in GBs
disk_usg=$(df -Ha | awk 'FNR == 2 {print $2,$3,$4,$5}') 

#### FUNCTIONS ####

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

hr(){
  # shellcheck disable=SC2183
  # print horizontal line of characters 

  printf '%*s\n' "${1:-$COLUMNS}" | tr ' ' "${2:-#}"
}

#### Meat & Potatoes ####

case $(uname -s) in

Darwin)
  # suppress last login in OS X by creating .hushlogin file  
  touch ~/.hushlogin

  # Memory free/used
  mem=$(top -l 1 -s 0 | awk '/PhysMem/ {print $2,$6}')

  # IP address 
  eth0=$(ipconfig getifaddr en0)

  # MAC address 
  macaddr=$(ifconfig en0 | awk '/ether/{print $2}')
  
  maus
  
  printf -- '%.30s: %s\n' "${HEADR[0]}$(hr 30 .)" "${host_name}" 
  printf -- '%.30s: %s\n' "${HEADR[1]}$(hr 30 .)" "${last_log}"
  printf -- '%.30s: %s\n' "${HEADR[2]}$(hr 30 .)" "${time_up}"
  printf -- '%.30s: %s\n' "${HEADR[3]}$(hr 30 .)" "${load_avg} (1 min 5 mins 15 mins)"
  printf -- '%.30s: %s\n' "${HEADR[4]}$(hr 30 .)" "${procs} (total)"
  printf -- '%.30s: %s\n' "${HEADR[5]}$(hr 30 .)" "${mem} (used unused)"
  printf -- '%.30s: %s\n' "${HEADR[6]}$(hr 30 .)" "${disk_usg} (size used avail capacity)"
  printf -- '%.30s: %s\n' "${HEADR[7]}$(hr 30 .)" "${eth0}" 
  printf -- '%.30s: %s\n' "${HEADR[8]}$(hr 30 .)" "${macaddr}"   
;;

Linux)
  # Memory free/used
  mem=$(free -g |awk 'FNR==2 {print $3, $4}') 
 
  # get IP address for eth0 (primary) 
  eth0=$(ip route get 1 | awk '{print $NF;exit}')
 
  # MAC ADDRESS
  macaddr=$(ip addr show eth0 |awk '/ether/{print $2}') 
 
  maus

  printf -- '%.30s: %s\n' "${HEADR[0]}$(hr 30 .)" "${host_name}" 
  printf -- '%.30s: %s\n' "${HEADR[1]}$(hr 30 .)" "${last_log}"
  printf -- '%.30s: %s\n' "${HEADR[2]}$(hr 30 .)" "${time_up}"
  printf -- '%.30s: %s\n' "${HEADR[3]}$(hr 30 .)" "${load_avg} (1 min 5 mins 15 mins)"
  printf -- '%.30s: %s\n' "${HEADR[4]}$(hr 30 .)" "${procs} (total)"
  printf -- '%.30s: %s\n' "${HEADR[5]}$(hr 30 .)" "${mem} (used unused)"
  printf -- '%.30s: %s\n' "${HEADR[6]}$(hr 30 .)" "${disk_usg} (size used avail capacity)"
  printf -- '%.30s: %s\n' "${HEADR[7]}$(hr 30 .)" "${eth0}" 
  printf -- '%.30s: %s\n' "${HEADR[8]}$(hr 30 .)" "${macaddr}" 
;;

*)
  printf "%s\\n" "He can't handle your speed $(uname -s)"
;; 
esac
