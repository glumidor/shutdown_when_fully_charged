#!/bin/bash

while true; do
	clear
	echo
	echo
	pmset -g batt 
	echo
	percent=$(pmset -g batt | grep "InternalBattery" | awk -F ";" '{print $1}' | awk -F " " '{print $3}' | sed "s/%//g" | sed "s/\s//g")
	remaining=$(pmset -g batt | grep "InternalBattery" | awk -F ";" '{print $3}' | awk -F " " '{print $1}' | awk -F ":" '{print $2}' | sed "s/\s//g")
	echo
	echo $percent "% charged"
	echo $remaining "min remaining"
	echo

	if [ $percent -gt 99 ] 
		then 
			afplay /System/Library/Sounds/Glass.aiff

			pmset -g batt

			remaining=$(pmset -g batt | grep "InternalBattery" | grep "finishing charge"| awk -F ";" '{print $3}' | awk -F " " '{print $1}' | awk -F ":" '{print $2}' | sed "s/\s//g")
			
			restzeit=$(expr $remaining + 5) # min

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
			# sudo shutdown -h now
			exit
	fi
	
	sleep 60
done
