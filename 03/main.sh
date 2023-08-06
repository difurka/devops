#! /bin/bash

function round_3 {
echo $(python3 -c "print(round($1/1024.0/1024, 3))")
}

function round_2 {
echo $(python3 -c "print(round(($1)/1024.0/1024.0, 2))")
}

function color_f {
case "$1" in
1) echo '\033[1;37m' ;;
2) echo '\033[1;31m' ;;
3) echo '\033[1;32m' ;;
4) echo '\033[1;34m' ;;
5) echo '\033[1;35m' ;;
6) echo '\033[1;30m' ;;
esac
}

function color_b {
case "$1" in
1) echo '\e[1;47m' ;;
2) echo '\e[1;41m' ;;
3) echo '\e[1;42m' ;;
4) echo '\e[1;44m' ;;
5) echo '\e[1;45m' ;;
6) echo '\e[1;40m' ;;
esac
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

if [ $# -eq 4 ];
then
    if (( 0 < "$1" )) && (( "$1" <= 6 )) && (( 0 < "$2" )) && (( "$2" <= 6 )) && \
       (( 0 < "$3" )) && (( "$3" <= 6 )) && (( 0 < "$4" )) && (( "$4" <= 6 ));
    then
        if [ "$1" != "$2" ] && [ "$3" != "$4" ];
        then
            BL=$(color_b $1)
            FL=$(color_f $2)
            BR=$(color_b $3)
            FR=$(color_f $4)
            FN='\033[0m'

            text="
            ${BL}${FL}HOSTNAME${FN} = ${BR}${FR}$(hostname)${FN}\
            \n${BL}${FL}TIMEZONE${FN} = ${BR}${FR}$(cat /etc/timezone) $(date +%Z)${FN}\
            \n${BL}${FL}USER${FN} = ${BR}${FR}$(whoami)${FN}
            \n${BL}${FL}OS${FN} = ${BR}${FR}$(cat /etc/issue | cut -d'\' -f1)${FN}
            \n${BL}${FL}DATE${FN} = ${BR}${FR}$(date +%d) $(date +%b) $(date +%Y) $(date +%T)${FN}
            \n${BL}${FL}UPTIME${FN} = ${BR}${FR}$(uptime -p)${FN}
            \n${BL}${FL}UPTIME_SEC${FN} = ${BR}${FR}$(cat /proc/uptime | cut -d' ' -f1)${FN}
            \n${BL}${FL}IP${FN} = ${BR}${FR}$ip${FN}
            \n${BL}${FL}MASK${FN} = ${BR}${FR}$(ifconfig | grep $ip | awk -F 'netmask'  '{print $2}' | cut -d ' ' -f2)${FN}
            \n${BL}${FL}GATEWAY${FN} = ${BR}${FR}$(ip route | grep default | cut -d ' ' -f3)${FN}
            \n${BL}${FL}RAM_TOTAL${FN} = ${BR}${FR}$ram_total GB${FN}
            \n${BL}${FL}RAM_USED${FN} = ${BR}${FR}$ram_used GB${FN}
            \n${BL}${FL}RAM_FREE${FN} = ${BR}${FR}$ram_free GB${FN}
            \n${BL}${FL}PACE_ROOT${FN} = ${BR}${FR}$ram_total MB${FN}
            \n${BL}${FL}SPACE_ROOT_USED${FN} = ${BR}${FR}$ram_used MB${FN}
            \n${BL}${FL}SPACE_ROOT_FREE${FN} = ${BR}${FR}$ram_free MB${FN}
            "
            
           echo -e ${text}
        else
            echo "The font and background colours of one column are matching"
        fi
    else
        echo "Parameters must be from 1 to 6"
    fi
else
    echo "Incorrect number of parameters"
fi