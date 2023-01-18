#! /bin/bash

function round_3 {
echo $(python3 -c "print(round($1/1024.0/1024.0, 3))")
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
HOSTNAME = $(hostname)
\nTIMEZONE = $(cat /etc/timezone) $(date +%Z)
\nUSER = $(whoami)
\nOS = $(cat /etc/issue | cut -d'\' -f1)
\nDATE = $(date +%d) $(date +%b) $(date +%Y) $(date +%T)
\nUPTIME = $(uptime -p)
\nUPTIME_SEC = $(cat /proc/uptime | cut -d' ' -f1)
\nIP = $ip
\nMASK = $(ifconfig | grep $ip | awk -F 'netmask'  '{print $2}' | cut -d ' ' -f2)
\nGATEWAY = $(ip route | grep default | cut -d ' ' -f3)
\nRAM_TOTAL = $ram_total GB
\nRAM_USED = $ram_used GB
\nRAM_FREE = $ram_free GB
\nPACE_ROOT = $ram_total MB
\nSPACE_ROOT_USED = $ram_used MB
\nSPACE_ROOT_FREE = $ram_free MB
"
echo -e $text

read -p "
---

writing the data to a file?  " answer
if [[ $answer = "y" ]] || [[ $answer = "Y" ]]; 
then
file_name="$(date +%d)_$(date +%m)_$(date +%Y)_$(date +%H)_$(date +%M)_$(date +%S).status"
echo -e $text >> $file_name
fi







