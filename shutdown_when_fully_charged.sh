#!/bin/bash

while true; do
	clear
	echo
	echo
	pmset -g batt 
	echo
	percent=$(pmset -g batt | grep "InternalBattery" | awk -F ";" '{print $1}' | awk -F " " '{print $3}' | sed "s/%//g" | sed "s/\s//g")
	remaining_hour=$(pmset -g batt | grep "InternalBattery" |  awk -F ";" '{print $3}' | awk -F " " '{print $1}' | awk -F ":" '{print $1}' | sed "s/\s//g")
	remaining_min=$(pmset -g batt | grep "InternalBattery" |  awk -F ";" '{print $3}' | awk -F " " '{print $1}' | awk -F ":" '{print $2}' | sed "s/\s//g")
	remaining=$(expr $remaining_hour \* 60 + $remaining_min)
	echo
	echo $percent "% charged"
	echo $remaining "min remaining"
	echo

	if [ $percent -gt 99 ] 
		then 
			afplay /System/Library/Sounds/Glass.aiff

			pmset -g batt

			remaining_hour=$(pmset -g batt | grep "InternalBattery" | grep "finishing charge" | awk -F ";" '{print $3}' | awk -F " " '{print $1}' | awk -F ":" '{print $1}' | sed "s/\s//g")
			remaining_min=$(pmset -g batt | grep "InternalBattery" |  grep "finishing charge" | awk -F ";" '{print $3}' | awk -F " " '{print $1}' | awk -F ":" '{print $2}' | sed "s/\s//g")
			remaining=$(expr $remaining_hour \* 60 + $remaining_min 2>/dev/null)
			
			restzeit=$(expr $remaining + 5 2>/dev/null) # min

			while [ $restzeit -ge 0 ]
			do 	
				clear
				echo
				pmset -g batt
				echo
				echo "shutdown in $restzeit min..."
				sleep 60
				((restzeit--))
			done

			afplay /System/Library/Sounds/Submarine.aiff
			sleep 10
			sudo shutdown -h now
			exit
	fi
	
	sleep 60
done
