# Example file for LinkedIn Learning Q2-09 Control high voltage
# uses SSR-40 DA

from gpiozero import Button
from signal import pause

def powerON():
    print("Hello!")

def powerOFF():
    print("Goodbye!")

button = Button(2)

button.when_pressed = powerON
button.when_released = powerOFF

pause()