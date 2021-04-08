# Example file for LinkedIn Learning Q2-12 analog to digital
# uses MCP3008

import gpiozero
import time

analogToDigital = gpiozero.MCP3008(channel = 0)

while True:
    print(analogToDigital.value)
    time.sleep(2)


