#! /bin/bash

function round {
echo $(python3 -c "print(round(($1)/1024.0/1024.0, $2))")
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

function recolor {
case "$1" in
1) echo white ;;
2) echo red ;;
3) echo green ;;
4) echo blue ;;
5) echo purple ;;
6) echo black ;;
esac
}

function state {
if (( $2 != 1));
then echo $1
else echo default
fi
}
ip=`hostname -I`
ram_total_in_mb=`free -t | grep Total | awk -F '[[:space:]][[:space:]]+' '{print$2}'`
ram_total=$(round $ram_total_in_mb 4)

ram_used_in_mb=`free -t | grep Total | awk -F '[[:space:]][[:space:]]+' '{print$3}'`
ram_used=$(round $ram_used_in_mb 4)

ram_free_in_mb=`free -t | grep Total | awk -F '[[:space:]][[:space:]]+' '{print$4}'`
ram_free=$(round $ram_free_in_mb 4)

root_total_in_mb=`df /boot/ -B1 | grep / | awk -F '[[:space:]][[:space:]]+' '{print$2}' | cut -d ' ' -f1`
ram_total=$(round $root_total_in_mb 2)

root_used_in_mb=`df /boot/ -B1 | grep / | awk -F '[[:space:]][[:space:]]+' '{print$2}' | cut -d ' ' -f2`
ram_used=$(round $root_used_in_mb 2)

root_free_in_mb=`df /boot/ -B1 | grep / | awk -F '[[:space:]][[:space:]]+' '{print$2}' | cut -d ' ' -f3`
ram_free=$(round $root_free_in_mb 2)

first=6
second=1
third=6
fourth=1
fd=0
sd=0
td=0
fod=0

find=`grep "column1_background" color.config | cut -d '=' -f2`
if [ $find ];
then first=$find
else fd=1
fi

find=`grep "column1_font_color" color.config | cut -d '=' -f2`
if [ $find ];
then second=$find
else sd=1
fi

find=`grep "column2_background" color.config | cut -d '=' -f2`
if [ $find ];
then third=$find
else td=1
fi

find=`grep "column2_font_color" color.config | cut -d '=' -f2`
if [ $find ];
then fourth=$find
else fod=1
fi



if (( 0 < $first )) && (( $first < 7 )) && \
   (( 0 < $second )) && (( $second < 7 )) && \
   (( 0 < $third )) && (( $third < 7 )) && \
   (( 0 < $fourth )) && (( $fourth  < 7));
then
    if [ $first != $second ] && [ $third != $fourth ];
    then
        BL=$(color_b $first)
        FL=$(color_f $second)
        BR=$(color_b $third)
        FR=$(color_f $fourth)
        FN='\033[0m'

        text="
        ${BL}${FL}HOSTNAME${FN} = ${BR}${FR}$(hostname)${FN}
        \n${BL}${FL}TIMEZONE${FN} = ${BR}${FR}$(cat /etc/timezone) $(date +%Z)${FN}
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

        echo -e "\nColumn 1 background = $(state $first $fd) ($(recolor $first)) \
                \nColumn 1 font color = $(state $second $sd) ($(recolor $second))  \
                \nColumn 2 background = $(state $third $td) ($(recolor $third))  \
                \nColumn 2 font color = $(state $fourth $fod) ($(recolor $fourth)) 
                "

    else
        echo "The font and background colours of one column are matching"
    fi
else
    echo "Parameters must be from 1 to 6"
fi
