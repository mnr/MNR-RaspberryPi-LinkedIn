from gpiozero import LED
from gpiozero.pins.pigpio import PiGPIOFactory
from time import sleep

factory = PiGPIOFactory(host='10.0.0.100')
led = LED(26, pin_factory=factory)

while True:
    led.on()
    sleep(1)
    led.off()
    sleep(1)
