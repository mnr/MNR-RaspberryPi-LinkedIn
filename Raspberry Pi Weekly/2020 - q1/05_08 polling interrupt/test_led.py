from gpiozero import LED
from time import sleep

theLED = LED(12)

for i in range(3):
    theLED.on()
    sleep(1)
    theLED.off()
    sleep(1)
    
theLED.off()