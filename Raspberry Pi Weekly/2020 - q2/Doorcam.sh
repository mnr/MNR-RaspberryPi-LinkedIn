#!/bin/bash

# take a picture, then compare it to a reference image
# "compare" comes from imagemagick. If you don't have it, you'll need to install it.
# sudo apt-get install imagemagick imagemagick-doc

# global variables
referenceImage="reference.jpg" # this is an image of the normal condition
comparisonImage="comparison.jpg" # this is an image used to detect rpi_motion
workingDirectory="/home/pi/rpi_motion" # this is a directory used for images
# doorbellButton=3 # BCM numbering scheme

# the Mean Average Error difference between reference and comparison that indicates movement
# a value of zero means detect ANY changes
# larger numbers (>10,000) reduce sensitivity
imageThreshold=10000

# respond to control-c
echo "Set up Control-c"
control_c() {
	rm $referenceImage
	rm $comparisonImage
	# echo $doorbellButton > /sys/class/gpio/unexport # clean up doorbell
	exit
}

trap control_c SIGINT

# echo "assign GPIO pin $doorbellButton as doorbell"
# echo $doorbellButton > /sys/class/gpio/export
# echo "in" > "/sys/class/gpio/gpio${doorbellButton}/direction"

# create working directory if necessary, then move to it
echo "Create working directory at $workingDirectory" # user feedback
if [ ! -d $workingDirectory ]
then
	mkdir $workingDirectory
fi

cd $workingDirectory

# create a reference image.
echo "Create a reference image at $referenceImage"
# if [ ! -f $referenceImage ]
# then
	raspistill -o $referenceImage
# fi

# check for motion
echo "Starting loop..."
while true; do
	#if [[ $(< "/sys/class/gpio/gpio${doorbellButton}/value") == "0" ]]
	#then
	#	echo "Someone is pressing the doorbell"
		# do something interesting...for example
		# IFTTT - https://linkedin-learning.pxf.io/rpi_ifttt
#	fi

	echo "Take a comparison image."
	raspistill -o $comparisonImage # take a comparison image

	# use imagemagick to compare the two images
	echo "Compare reference and comparison images."
	meanAvgError=`(compare -metric MAE $referenceImage $comparisonImage null: 2>&1)`
	justMeanae=${meanAvgError% (*}
	echo "Mean Average Error is $justMeanae"

	# then act on MAE
	if [ ${justMeanae%.*} -gt $imageThreshold ] ; then
		echo "MAE is greater than $imageThreshold. Someone is on the porch"
		echo "Raspberry Pi is recording a video"
		raspivid -o doorcam$(date +"%Y%m%d_%H%M%S").h264 -t 20000 --width 640 --height 360
	else
		echo "MAE is less than or equal to $imageThreshold. Nothing to see..."
	fi
done
