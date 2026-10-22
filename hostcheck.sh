#!/bin/bash

if [[ -z $1 ]]; then
	echo -n "Enter the target address: "
	read target

	if [[ -z $target ]]; then
		echo "[ERROR] No target address. Exiting."
		exit 1
	else
		counter=0
		max_attempts=20 # 20 - 1 min, 40 - 2 min, etc.
		while true; do

			if ping -c 2 -w 2 "$target" &> /dev/null; then
				echo "[UP] $target is UP."
				break
			else
				echo "[DOWN] $target is currently DOWN."
				(( counter++ ))

				max_attempts=20 # 20 - 1 min, 40 - 2 min, etc.

				if (( counter > max_attempts )); then
					echo "[ERROR] Target address did not respond. Exiting."
					exit 1
				fi
			fi
			sleep 1
		done
	fi
else
	counter=0
	max_attempts=20 # 20 - 1 min, 40 - 2 min, etc.
	while true; do
		if ping -c 2 -w 2 "$1" &> /dev/null; then
			echo "[UP] $1 is UP."
			break
		else
			echo "[DOWN] $1 is currently DOWN."
			(( counter++ ))

			if (( counter > max_attempts )); then
				echo "[ERROR] Target address did not respond. Exiting."
				exit 1
			fi
		fi
		sleep 1
	done

fi
