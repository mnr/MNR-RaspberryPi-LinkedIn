# critter detector - Interrupt solution

from gpiozero import DistanceSensor, Button, LED
from signal import pause

dsense = DistanceSensor(echo = 24, trigger = 18)
button = Button(16)
theLED = LED(12)

def IntruderAlert(device):
    if (type(device) == DistanceSensor):
        theLED.blink(on_time = .25, off_time = .75, n = 10, background = True)
        print("Proximity: Intruder Alert!")
    else:
        print("Button: Intruder Alert!")
        theLED.blink(on_time = .75, off_time = .25, n = 10, background = True)

dsense.when_in_range = IntruderAlert
button.when_pressed = IntruderAlert

pause()

