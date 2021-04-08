#!/bin/bash


# Don't forget to install libgpiod
# sudo apt-get install gpiod libgpiod-dev libgpiod-doc
# documentation: https://manpages.debian.org/experimental/gpiod/ 

##################
# config
btnAlpha=15 # BCM numbering scheme 
btnGamma=14 # BCM numbering scheme 

# either of these work
chipName=$(awk -F"[][]" '/gpiochip0/ { print $2 }' <( gpiodetect ))
chipName=gpiochip0

###################
# working loop
while :
do
	if [[ $(gpioget $chipName $btnAlpha) == "0" ]]
	then
		echo "Alpha"
	fi

	if [[ $(gpioget $chipName $btnGamma) == "0" ]]
	then
		echo "Gamma"
	fi
	
done
