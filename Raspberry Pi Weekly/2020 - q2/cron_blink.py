# Write your code here :-)
from gpiozero import LED
from datetime import datetime

blinker = LED(2)

blinker.blink(n=5, background=False)

print(datetime.now(), "I'm Blinking")

blinker.off()