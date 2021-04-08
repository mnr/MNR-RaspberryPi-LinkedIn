# sample code for LinkedIn Learning q2-08 Stepper Motor
# assumes L293D driver and 28BYJ-48 motor

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

# The steps to turning the motor. "1" turns the coil on
# either sequence works
# turn_clockwise = [(1,0,1,0),(0,1,1,0),(0,1,0,1),(1,0,0,1)]
turn_clockwise = [(0,1,0,0), (0,1,0,1), (0,0,0,1), (1,0,0,1), (1,0,0,0), (1,0,1,0), (0,0,1,0), (0,1,1,0)]
turn_counterCW = turn_clockwise[::-1] # reverse the order of the list

def turnTheMotor(delay, steps, coilSequence):
    for i in range(0, steps):
        for coil_onoff in coilSequence:
            GPIO.output(pin_list, coil_onoff)
            time.sleep(delay)

delay = .001 # .001 is fast. .01 is slow. .0001 is too fast to work
steps = 100 # 512 is a full rotation. 10 just jitters

for theCycle in range(1,10):
  turnTheMotor(delay, steps, turn_clockwise)
  turnTheMotor(delay, steps, turn_counterCW)
  print("one cycle")
  
GPIO.cleanup()
