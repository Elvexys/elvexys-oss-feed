#!/bin/sh
# Created by Elvexys, inpired on the file lora-concentrator-reset.sh from Wifx Sàrl <info@wifx.net>

pin=1

logger "Reset SX130x"

if [ -d "/sys/class/gpio/pioA${pin}" ]
then
	echo 1 > /dev/null
else
	echo ${pin} > /sys/class/gpio/export
	echo "out" > /sys/class/gpio/pioA${pin}/direction
fi

echo "1" > /sys/class/gpio/pioA${pin}/value
sleep 5
echo "0" > /sys/class/gpio/pioA${pin}/value
sleep 1
echo "0" > /sys/class/gpio/pioA${pin}/value

logger "SX130x reset completed"
