# sample code for q2-08 Stepper Motor

import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BOARD)

L293D_enable = 12
L293D_1A = 7
L293D_2A = 11
L293D_3A = 18
L293D_4A = 16

GPIO.setup(L293D_enable, GPIO.OUT)
#pulseWidthMod = GPIO.PWM(L293D_enable, 50)
#pulseWidthMod.start(1)

GPIO.setup(L293D_1A, GPIO.OUT)
GPIO.setup(L293D_2A, GPIO.OUT)
GPIO.setup(L293D_3A, GPIO.OUT)
GPIO.setup(L293D_4A, GPIO.OUT)

GPIO.output(L293D_enable, 1)

def forward(delay, steps):  
  for i in range(0, steps):
    setStep(1, 0, 1, 0)
    time.sleep(delay)
    setStep(0, 1, 1, 0)
    time.sleep(delay)
    setStep(0, 1, 0, 1)
    time.sleep(delay)
    setStep(1, 0, 0, 1)
    time.sleep(delay)

def backwards(delay, steps):  
  for i in range(0, steps):
    setStep(1, 0, 0, 1)
    time.sleep(delay)
    setStep(0, 1, 0, 1)
    time.sleep(delay)
    setStep(0, 1, 1, 0)
    time.sleep(delay)
    setStep(1, 0, 1, 0)
    time.sleep(delay)

  
def setStep(w1, w2, w3, w4):
  GPIO.output(L293D_1A, w1)
  GPIO.output(L293D_2A, w2)
  GPIO.output(L293D_3A, w3)
  GPIO.output(L293D_4A, w4)

while True:
  # delay = raw_input("Delay between steps (milliseconds)?")
  # steps = raw_input("How many steps forward? ")
  delay = 5
  steps = 100
  forward(int(delay) / 1000.0, int(steps))
  # steps = raw_input("How many steps backwards? ")
  steps = 100
  backwards(int(delay) / 1000.0, int(steps))
  print("one cycle")
  
GPIO.cleanup()