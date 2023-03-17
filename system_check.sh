#!/bin/bash

cpu_threshold=75
mem_threshold=75
disk_threshold=70

cpu_usage=$(top  -bn1 | awk '/Cpu/{print $2}' | cut -d. -f1)
mem_usage=$(free | awk '/Mem/{printf("%d\n",$3/$2*100)}')
disk_usage=$(df -h | awk '$NF=="/"{printf "%d\n",$5}')

#check the cpu usage
if [ "$cpu_usage" -gt "$cpu_threshold" ]; 
then
	message="[CRITICAL] [CPU: $cpu_usage%]"
	echo "$(date) $message" >> /var/log/check_system.log
	subject="Alert messsage"
	To="belwalrohit642@gmail.com"
        echo -e "$message" | mail -s "$subject" "$To"	
elif [ "$cpu_usage" -gt 50 ] && [ "$cpu_usage" -lt "$cpu_threshold" ];
then
	message="[WARNING] [CPU: $cpu_usage%]"
        echo "$(date) $message" >> /var/log/check_system.log
elif [ "$cpu_usage" -lt 50 ];
then
	message="[NORMAL] [CPU :$cpu_usage%]"
	echo "$(date) $message" >> /var/log/check_system.log
fi


#check memory usage
if [ "$mem_usage" -gt "$mem_threshold" ];
then
	message="[CRITICAL] [MEM: $mem_usage%]"
	echo "$(date) $message" >> /var/log/check_system.log
	subject="Alert messsage"
        To="belwalrohit642@gmail.com"
        echo -e "$message" | mail -s "$subject" "$To"
elif [ "$mem_usage" -gt 50 ] && [ "$mem_usage" -lt "$mem_threshold" ];
then
        message="[WARNING] [MEM: $mem_usage%]"
        echo "$(date) $message" >> /var/log/check_system.log
elif [ "$mem_usage" -lt 50 ];
then
        message="[NORMAL] [MEM :$mem_usage%]"
        echo "$(date) $message" >> /var/log/check_system.log
fi

#check disk usage
if [ "$disk_usage" -gt "$disk_threshold" ];
then
	message="[CRITICAL] [DISK SPACE: $disk_usage]"
	echo "$(date) $message" >> /var/log/check_system.log
	subject="Alert messsage"
        To="belwalrohit642@gmail.com"
        echo -e "$message" | mail -s "$subject" "$To"
elif [ "$disk_usage" -gt 50 ] && [ "$disk_usage" -lt "$disk_threshold" ];
then
        message="[WARNING] [DISK SPACE: $disk_usage%]"
        echo "$(date) $message ">> /var/log/check_system.log
        subject="Alert messsage"
        To="belwalrohit642@gmail.com"
        echo -e "$message" | mail -s "$subject" "$To"

elif [ "$disk_usage" -lt 50 ];
then
        message="[NORMAL] [DISK SPACE :$disk_usage%]"
        echo "$(date) $message ">> /var/log/check_system.log


fi
