#!/bin/bash 
# mjk 2018.09.28 

# header array 
HEADR=(Hostname Uptime "Last Login" "Load Averages" "Running Processes" "Memory Usage" "Disk Usage" "Time")

dots(){ 
  # seq increments a period (".") 1-n times, where n is user defined   
  
  printf "%s" "$2"; 
  printf "%.0s." $( seq $(($1-${#2})) );
  echo; 
}

host_name(){
  # fully-qualified domain name 
  
  host=$(hostname -f)
  printf "%s" "$host"  
}  

time_up(){ 
  # uptime: days hours:minutes 
  
  timeup=$(uptime | sed 's/,//g' | awk '{ print $3,$4,$5}')
  printf "%s" "$timeup" 
} 


# last login 

last_login=$(last | awk 'NR==2'|tr -s ' ')

# load avgs. over the past 1,5,15 min. intvls. 
load_avg=$(uptime | awk -F'[a-z]:' '{print $2}') 

# today: year month hour minute 24-hour timezone(abbr.)
today=$(date +"%Y %B %e, %A, %T %Z")

# running processes
processes=$(ps ax | wc -l | tr -d " ")

# memory stats: used unused 
# works in BSD not Linux; need to generalize 
mem_info=$(top -l 1 -s 0 | awk '/PhysMem/ {print $2,$6}')

# disk stats: size used avail. capacity in GBs
disk_usg=$(df -Ha | awk 'FNR == 2 {print $2,$3,$4,$5}') 



printf "%s" "
  )      |${HEADR[0]}.........: `host_name`      
 (__     |${HEADR[1]}...........: ${timeup}
 _  )_   |${HEADR[2]}.......: ${last_login} 
(_)_(_)  |${HEADR[3]}....: ${load_avg} (1, 5, 15 min)  
 (o o)   |${HEADR[4]}: ${processes}  
==\o/==  |${HEADR[5]}.....: ${mem_info} (used unused) 
         |${HEADR[6]}.......: ${disk_usg} (size used avail capacity) 
         |${HEADR[7]}:`dots 12`: ${timeup}  
" 

