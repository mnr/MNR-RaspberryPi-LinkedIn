# This is the program used to narrate the opening lines of the LinkedIn Learning Session

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
 
thingsToSay = ("its naught unCOMmon for computers to talk",
               "And there are lots of services that will convert text to speech",
                "But it would be handy to have text to speech without relying on an internet service",
               "Parallax has introduced Emics two",
               "it is an easy to use integrated module that adds onboard text to speech to your Raspberry Pi Project",
               "In fact, you are hearing speech from Emics right now",
               "Lets take a look at how to connect Emics to a raspberry pi and how to program it to speak."
    )

whichLine = 0
speakAString("W", 200) #words per minute
speakAString("V", 0) # volume
speakAString("N", 0) # voice

while (whichLine < len(thingsToSay)):
    speakAString("s",thingsToSay[whichLine])

    myPrompt = "which line to speak? (0 to " + str(len(thingsToSay)-1) + ")"
    whichLine = int(input( myPrompt ) )

   
