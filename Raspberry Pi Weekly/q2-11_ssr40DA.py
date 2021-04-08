# Example file for LinkedIn Learning Q2-11 Control high voltage
# uses SSR-40 DA

import gpiozero
from signal import pause

ssRelay = gpiozero.DigitalOutputDevice(4)

ssRelay.blink()

pause()
