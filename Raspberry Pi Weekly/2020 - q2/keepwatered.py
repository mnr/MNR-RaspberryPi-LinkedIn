from gpiozero import MCP3008, DigitalOutputDevice
from datetime import datetime
import time
import signal

moistureSensor = MCP3008(channel = 0)
waterPump = DigitalOutputDevice(26)

# handle interrupts
def controlC (sig, frame):
    waterPump.close()
    exit(0)

signal.signal(signal.SIGINT, controlC)

# water the plant
while True:
    print("WAIT: ")
    time.sleep(5) # wait for five seconds
    print("CHECK: ", datetime.now(tz=None), "-", moistureSensor.value)
    if (moistureSensor.value < .1):
        print("PUMP: Moisture is ", moistureSensor.value)
        waterPump.blink(on_time = 1, off_time = 1, n = 1) # pump once
    else:
        print("Soil Moisture is okay.")
        