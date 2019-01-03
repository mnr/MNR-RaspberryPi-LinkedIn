# code to run the HC-SR604 ultrasonic Range Finder

import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BOARD)

HCSR604_TRIG = 12
HCSR604_ECHO = 18

GPIO.setup(HCSR604_TRIG, GPIO.OUT)
GPIO.setup(HCSR604_ECHO, GPIO.IN, pull_up_down = GPIO.PUD_DOWN)

try:
    while True:
        # put the trigger into a known state
        GPIO.output(HCSR604_TRIG, True)
        time.sleep(0.00001) # pause for .01 milliseconds
        GPIO.output(HCSR604_TRIG, False)
        
        # start a timer
        while GPIO.input(HCSR604_ECHO) == 0:
            whenPulseSent = time.time()
            
        # time the echo
        while GPIO.input(HCSR604_ECHO) == 1:
            whenPulseReturn = time.time()
            
        # timer
        echoDuration = (whenPulseReturn - whenPulseSent) / 2
        # divide by two because pulse covers twice the distance - out and back
        
        speedOfSound = 34300 #centimeters per second
        howFar = echoDuration * speedOfSound
        
        print("Distance: %.1f centimeters" % howFar)
        
        time.sleep(1) # pause for one second
    
except KeyboardInterrupt:
    # control C stops the program
    GPIO.cleanup()