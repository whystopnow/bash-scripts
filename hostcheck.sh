#!/bin/bash

echo -n "Type the target's IP address: "
read target

while true; do
	if ping -c 2 -w 2 "$target" > /dev/null; then
		echo "[UP] $target is UP."
		break
	else
		echo "[DOWN] $target is currently DOWN."
	fi
	sleep 1
done
