# sample code for LinkedIn Learning q2-08 Stepper Motor

import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BOARD)

L293D_enable = 12
L293D_1A = 7
L293D_2A = 11
L293D_3A = 18
L293D_4A = 16

# set up output pins
pin_list = [L293D_1A, L293D_2A, L293D_3A, L293D_4A]
GPIO.setup(pin_list, GPIO.OUT)

# enable chip
GPIO.setup(L293D_enable, GPIO.OUT)
GPIO.output(L293D_enable, 1)

# The four steps to turning the motor. 1 means to turn on the coil
coil_seq = [(1,0,1,0),(0,1,1,0),(0,1,0,1),(1,0,0,1)]

def forward(delay, steps):
    print("forward")
    for i in range(0, steps):
        for coil_onoff in coil_seq:
            w1,w2,w3,w4 = coil_onoff
            GPIO.output(pin_list, (w1, w2, w3, w4))
            time.sleep(delay)

def backwards(delay, steps):
    print("backwards")
    for i in range(0, steps):
        for coil_onoff in reversed(coil_seq):
            w1,w2,w3,w4 = coil_onoff
            GPIO.output(pin_list, (w1, w2, w3, w4))
            time.sleep(delay)

delay = 5
steps = 100

while True:
  forward(int(delay) / 1000.0,steps)
  backwards(int(delay) / 1000.0, int(steps))
  print("one cycle")
  
GPIO.cleanup()
