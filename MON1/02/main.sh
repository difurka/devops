#! /bin/bash

echo "HOSTNAME: $HOSTNAME"

tz=`cat /etc/timezone`
hours=`date +%Z`
echo "TIMEZONE: $tz $hours"

echo "USER: $(whoami)"

os_name=`cat /etc/issue | cut -d'\' -f1`   #`grep PRETTY_NAME /etc/os-release`
echo "OS: $os_name"

day=`date +%d`
month=`date +%b`
year=`date +%Y`
time=`date +%T`
echo "DATE: $day $month $year $time"

echo "UPTIME: $(uptime -p)"

time_in_sec=`cat /proc/uptime | cut -d' ' -f1`
echo "UPTIME_SEC: $time_in_sec"

# ip=`ifconfig eth0 | grep "inet addr" | head -n 1 | cut -d : -f 2 | cut -d " " -f 1`
ip=`hostname -I`
echo "IP: $ip"

mask=`ifconfig | grep $ip |cut -d '$(ip)' -f 1-30`
echo "MASK: $mask"

# echo "GATEWAY: $user"

# echo "RAM_TOTAL: $user"

# echo "RAM_USED: $user"

# echo "RAM_FREE: $user"

# echo "SPACE_ROOT: $user"

# echo "SPACE_ROOT_USED: $user"

# echo "SPACE_ROOT_FREE: $user"







