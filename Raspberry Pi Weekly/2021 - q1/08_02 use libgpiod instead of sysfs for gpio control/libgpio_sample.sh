#!/bin/bash

# demonstration of libgiod

# install libgpiod with
Sudo apt-get update

sudo apt-get install gpiod libgpiod-dev libgpiod-doc

# now you have new commands...

##############
gpioget 0 14 # returns value of gpio14

gpioget gpiochip0 14 # same thing
gpioget pinctrl-bcm2835 14 # also same thing

##############
gpiodetect # returns available gpio banks

