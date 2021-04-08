# critter detector - polling solution

from gpiozero import DistanceSensor, Button, LED
from time import sleep

dsense = DistanceSensor(echo = 24, trigger = 18)
button = Button(16)
theLED = LED(12)
 
def IntruderAlert(device):
    if (device == "DistanceSensor"):
        theLED.blink(on_time = .25, off_time = .75, n = 10, background = True)
        print("Proximity: Intruder Alert!")
    else:
        print("Button: Intruder Alert!")
        theLED.blink(on_time = .75, off_time = .25, n = 10, background = True)


try:
    while True:
        sleep(3)
        intruderDistance = dsense.distance
        print(intruderDistance)
        if (intruderDistance < .3):
            IntruderAlert("DistanceSensor")
        if (button.is_pressed):
            IntruderAlert("Button")
            
except KeyboardInterrupt:
    print("cleanup")