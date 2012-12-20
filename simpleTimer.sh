#!/bin/sh

PIN=25

test $(id -u) -eq 0 || {
	echo "Root privileges needed to drive GPIO pin"
	exit 1
}

GPIO=/sys/class/gpio

echo $PIN > $GPIO/export

echo low > $GPIO/gpio$PIN/direction

value() {
	echo $1 > $GPIO/gpio$PIN/value
}

# this is a loop with 1 hour and 30 second period
# not one hour. tough.
while true; do
	value 1 ; sleep 30
	value 0 ; sleep 3600 # 60 minutes
done
