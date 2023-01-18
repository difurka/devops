#! /bin/bash

function round_3 {
echo $(python3 -c "print(round($1/1024.0/1024, 3))")
}

function round_2 {
echo $(python3 -c "print(round(($1)/1024.0/1024.0, 2))")
}


ip=`hostname -I`
ram_total_in_mb=`free -t | grep Total | awk -F '[[:space:]][[:space:]]+' '{print$2}'`
ram_total=$(round_3 $ram_total_in_mb)

ram_used_in_mb=`free -t | grep Total | awk -F '[[:space:]][[:space:]]+' '{print$3}'`
ram_used=$(round_3 $ram_used_in_mb)

ram_free_in_mb=`free -t | grep Total | awk -F '[[:space:]][[:space:]]+' '{print$4}'`
ram_free=$(round_3 $ram_free_in_mb)

root_total_in_mb=`df /boot/ -B1 | grep / | awk -F '[[:space:]][[:space:]]+' '{print$2}' | cut -d ' ' -f1`
ram_total=$(round_2 $root_total_in_mb)

root_used_in_mb=`df /boot/ -B1 | grep / | awk -F '[[:space:]][[:space:]]+' '{print$2}' | cut -d ' ' -f2`
ram_used=$(round_2 $root_used_in_mb)

root_free_in_mb=`df /boot/ -B1 | grep / | awk -F '[[:space:]][[:space:]]+' '{print$2}' | cut -d ' ' -f3`
ram_free=$(round_2 $root_free_in_mb)

text="
HOSTNAME: $(hostname)
TIMEZONE: $(cat /etc/timezone) $(date +%Z)
USER: $(whoami)
OS: $(cat /etc/issue | cut -d'\' -f1)
DATE: $(date +%d) $(date +%b) $(date +%Y) $(date +%T)
UPTIME: $(uptime -p)
UPTIME_SEC: $(cat /proc/uptime | cut -d' ' -f1)
IP: $ip
MASK: $(ifconfig | grep $ip | awk -F 'netmask'  '{print $2}' | cut -d ' ' -f2)
GATEWAY: $(ip route | grep default | cut -d ' ' -f3)
RAM_TOTAL: $ram_total GB
RAM_USED: $ram_used GB
RAM_FREE: $ram_free GB
PACE_ROOT: $ram_total MB
SPACE_ROOT_USED: $ram_used MB
SPACE_ROOT_FREE: $ram_free MB
"


# echo "HOSTNAME: $HOSTNAME"
# echo "TIMEZONE: $(cat /etc/timezone) $(date +%Z)"
# echo "USER: $(whoami)"
# echo "OS: $(cat /etc/issue | cut -d'\' -f1)"
# echo "DATE: $(date +%d) $(date +%b) $(date +%Y) $(date +%T)"
# echo "UPTIME: $(uptime -p)"
# echo "UPTIME_SEC: $(cat /proc/uptime | cut -d' ' -f1)"
# echo "IP: $ip"
# echo "MASK: $(ifconfig | grep $ip | awk -F 'netmask'  '{print $2}' | cut -d ' ' -f2)"
# echo "GATEWAY: $(ip route | grep default | cut -d ' ' -f3)"
# echo "RAM_TOTAL: $ram_total GB"
# echo "RAM_USED: $ram_used GB"
# echo "RAM_FREE: $ram_free GB"
# echo "PACE_ROOT: $ram_total MB"
# echo "SPACE_ROOT_USED: $ram_used MB"
# echo "SPACE_ROOT_FREE: $ram_free MB"

echo $text

temp="ttt"

read -p "
---

writing the data to a file?  " answer
if [[ $answer = "y" ]] || [[ $answer = "Y" ]]; 
then
file_name="$(date +%d)_$(date +%m)_$(date +%Y)_$(date +%H)_$(date +%M)_$(date +%S).status"

temp="ttt"
$(temp) >> $file_name
fi







