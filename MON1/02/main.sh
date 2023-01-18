#! /bin/bash

echo "HOSTNAME: $HOSTNAME"

echo "TIMEZONE: $(cat /etc/timezone) $(date +%Z)"

echo "USER: $(whoami)"

echo "OS: $(cat /etc/issue | cut -d'\' -f1)"

echo "DATE: $(date +%d) $(date +%b) $(date +%Y) $(date +%T)"

echo "UPTIME: $(uptime -p)"

echo "UPTIME_SEC: $(cat /proc/uptime | cut -d' ' -f1)"

ip=`hostname -I`
echo "IP: $ip"

echo "MASK: $(ifconfig | grep $ip | awk -F 'netmask'  '{print $2}' | cut -d ' ' -f2)"

echo "GATEWAY: $(ip route | grep default | cut -d ' ' -f3)"

function round_3 {
echo $(python3 -c "print(round($1/1024.0/1024, 3))")
}

ram_total_in_mb=`free -t | grep Total | awk -F '[[:space:]][[:space:]]+' '{print$2}'`
ram_total=$(round_3 $ram_total_in_mb)
echo "RAM_TOTAL: $ram_total GB"

ram_used_in_mb=`free -t | grep Total | awk -F '[[:space:]][[:space:]]+' '{print$3}'`
ram_used=$(round_3 $ram_used_in_mb)
echo "RAM_USED: $ram_used GB"

ram_free_in_mb=`free -t | grep Total | awk -F '[[:space:]][[:space:]]+' '{print$4}'`
ram_free=$(round_3 $ram_free_in_mb)
echo "RAM_FREE: $ram_free GB"


function round_2 {
echo $(python3 -c "print(round(($1)/1024.0/1024.0, 2))")
}
root=`df /boot/ -B1`

root_total_in_mb=`df /boot/ -B1 | grep / | awk -F '[[:space:]][[:space:]]+' '{print$2}' | cut -d ' ' -f1`
ram_total=$(round_2 $root_total_in_mb)
echo "PACE_ROOT: $ram_total MB"

root_used_in_mb=`df /boot/ -B1 | grep / | awk -F '[[:space:]][[:space:]]+' '{print$2}' | cut -d ' ' -f2`
ram_used=$(round_2 $root_used_in_mb)
echo "SPACE_ROOT_USED: $ram_used MB"

root_free_in_mb=`df /boot/ -B1 | grep / | awk -F '[[:space:]][[:space:]]+' '{print$2}' | cut -d ' ' -f3`
ram_free=$(round_2 $root_free_in_mb)
echo "SPACE_ROOT_FREE: $ram_free MB"








