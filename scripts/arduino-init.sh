#!/usr/bin/env bash

if [[ $EUID > 0 ]]; then  
	echo "Please run as root/sudo"
	exit 1
else  
	echo "Checking for prerequisites..."

	echo which ardunio
	echo which arduino-cli

	echo "Install arduino-cli and arduino IDE if the above commands return nothing"

	echo "Enabling serial port access for user"

	ls /dev/ttyACM0
	sudo chmod a+rw /dev/ttyACM0
fi

