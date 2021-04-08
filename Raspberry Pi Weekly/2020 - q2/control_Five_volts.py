from gpiozero import LED
from signal import pause

LED3v = LED(2)
LED5v = LED(10)
SCRcntl = LED(26)

LED3v.blink()
LED5v.blink()
SCRcntl.blink()

pause()

LED3v.off()
LED5v.off()
SCRcntl.off()