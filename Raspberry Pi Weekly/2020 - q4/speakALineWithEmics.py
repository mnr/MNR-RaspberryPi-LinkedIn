# feed a line of text to Emic

import serial
import random
import time

ser = serial.Serial(
    port='/dev/ttyS0',
    baudrate = 9600,
    parity=serial.PARITY_NONE,
    stopbits=serial.STOPBITS_ONE,
    bytesize=serial.EIGHTBITS
    )

   
def speakAString( theCommand, sayThis):
    time.sleep(.25) # pause to give Emics a secod to reset
    
    sayThisFormatted = theCommand + str(sayThis) + "\r" # Emics requires lines to end in return
    # print("sending",sayThisFormatted)
    ser.write(sayThisFormatted.encode())
    
sayThis = "nothing yet"


while (sayThis != "stop"):
    # choose a random voice
    theVoice = random.randint(0,8)
    speakAString("N",theVoice)
    print("Speaking with voice #", theVoice)
    
    # choose a speed
    theSpeed = random.randint(75,250) #set speaking rate. max = 600
    speakAString("W",theSpeed)
    print("Speaking Rate: ",theSpeed)
    
    # choose a volume
    theVolume = random.randint(-20,18) # Minimum is -48, but you can't hear it
    speakAString("V", theVolume)
    print("Volume: ", theVolume)
              
    sayThis = input("Listening to you: ")
    print("Speaking: ", sayThis)
    speakAString("S", sayThis)
    
    print("\n\n")

ser.close()

