#!/bin/bash

# Script to control a fan to cool SOC
# Use this version for chron

# globals
highSOCTemp=35
fanLocation=10 # board pin 19

# connect fan to gpio
echo $fanLocation > /sys/class/gpio/export
sleep 1s # give system time to configure the export
echo "out" > "/sys/class/gpio/gpio${fanLocation}/direction"

getSOCTemp() {
	rpiTemptmp=$(vcgencmd measure_temp)
    echo ${rpiTemptmp:5:2}
}

# enter something in log file
echo "$(date): Temp is:  $(getSOCTemp)"

# runs to cool the SOC
while [[ $(getSOCTemp) -gt $highSOCTemp ]]; do 	
    echo "1" > "/sys/class/gpio/gpio${fanLocation}/value"
done

# gracefully exit when SOC is cool.
echo "0" > "/sys/class/gpio/gpio${fanLocation}/value"
echo $fanLocation > /sys/class/gpio/unexport
