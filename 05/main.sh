#!/bin/bash

if [ $# -eq 1 ];
then
    if [ -d $1 ];
    then
        start=`date +%s`

        cd $1  
        echo "Total number of folders (including all nested ones) = $(( `find . -type d | wc -l` - 1 ))"
        
        echo -e "\nTOP 5 folders of maximum size arranged in descending order (path and size): \
              \n$(find . -type d -printf '  %p %s\n'| sort -nr -k2 | head -5 | awk 'BEGIN{i=1} /.*/{printf "%d.% s\n",i,$0; i++}')\n"
        echo "Total number of files = `find . -type f | wc -l`"
        echo "Number of:"
        echo "Configuration files (with the .conf extension) = $(find . -type f -iname "*.conf" | wc -l)"
        echo "Text files = $(find . -type f -iname "*.txt" | wc -l)"
        echo "Executable files = $(find . -type f -perm /a=x | wc -l)"
        echo "Log files (with the extension .log) = $(find . -type f -iname "*.log" | wc -l)" 
        echo "Archive files = $(find . -type f -iname "*.tar" | wc -l)"
        echo "Symbolic links = $(find . -type l | wc -l)"

        echo -e "\nTOP 10 files of maximum size arranged in descending order (path, size and type):"
        for ((i = 1; i <= 10; i++))
            do
            file=$(find . -type f  -printf ' %p %s\n'| sort -nr -k2 | head -$((0 + $i)) | tail -1 | awk '{printf $1}')
            echo -e "$i. $file, \t $(ls -lh $file | awk '{printf $5}'), \t $(file $file | awk '{printf $2}')"
            done

        echo -e "\nTOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
            for ((i = 1; i <= 10; i++))
            do
            file=$(find . -type f -perm /a=x  -printf ' %p %s\n'| sort -nr -k2 | head -$((0 + $i)) | tail -1 | awk '{printf $1}')
            echo -e "$i. $file, \t $(ls -lh $file | awk '{printf $5}'), \t$(md5sum  $file | awk '{printf $1}')"
            done

        end=`date +%s`
        echo -e "\nScript execution time (in seconds) = $((end-start))"
    else 
        echo "Incorrect folder"
    fi
else
    echo "Incorrect number of parameters"
fi
