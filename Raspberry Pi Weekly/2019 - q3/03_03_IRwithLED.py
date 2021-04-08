# code to run LEDs with Rangefinder

from gpiozero import PWMLED, RGBLED, DistanceSensor
import time

singleLED = PWMLED(14)
rgbLED = RGBLED(16, 20, 21)
rangefind = DistanceSensor(24, 18)


# Test the LEDs

# turn on the RGB LED
rgbLED.color = (1,0,0) # red
time.sleep(1)
rgbLED.color = (0,1,0) # green
time.sleep(1)
rgbLED.color = (0,0,1) # blue
time.sleep(1)
rgbLED.color = (1, 1, 1) # bright white
time.sleep(1)
rgbLED.color = (.01, .01, .01) # dim white
time.sleep(1)
rgbLED.off()

# turn on LED
singleLED.value = .01 # dim
time.sleep(1)
singleLED.value = 1 # bright
time.sleep(1)
singleLED.off()

# test the Rangefinder
for thisloop in range(0,5):
    print(thisloop, ' - Distance to nearest object is', rangefind.distance, 'm')
    time.sleep(1)

# control the LEDs with the rangefinder
while True:
    rangefindDistance = rangefind.distance
    DIST = rangefindDistance if rangefindDistance <= 1 else 1
    invDIST = .1/rangefindDistance if .1/rangefindDistance <= 1 else 1
    print( DIST, "-", invDIST)
    if DIST < 1:
        singleLED.blink(on_time = DIST, off_time = invDIST)
    else:
         singleLED.off()   
    rgbLED.color = (invDIST, DIST, 0)
    time.sleep(.1)
    
# note that I don't gracefully handle program termination.


