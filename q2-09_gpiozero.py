# alternative code from q2-06_hc-sr604 using gpiozero instead of RPi.GPIO

from gpiozero import DistanceSensor
from time import sleep

# defined in BCM - NOT board pins
HCSR604_TRIG = 18 # which is Board Pin 12
HCSR604_ECHO = 24 # which is Board Pin 18

sensor = DistanceSensor(HCSR604_ECHO, HCSR604_TRIG)

while True:
    print('Distance to nearest object is', sensor.distance * 100, ' cm')
    sleep(1)