from gpiozero import LED, Button
from signal import pause

mySwitch = Button(2)
myLED = LED(26)

# test the connections
# myLED.blink()

myLED.source = mySwitch

pause()


