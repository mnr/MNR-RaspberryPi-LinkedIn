# example code for raspberry pi portal
# assumes a button for GPIO
# written for LinkedIn Learning - Raspberry Pi Weekly
# Author: Mark Niemann-Ross (mark.niemannross@gmail.com)
# thanks to https://www.stuffaboutcode.com/p/minecraft-api-reference.html

from mcpi import minecraft, block, vec3
import gpiozero
from colorzero import Color
from time import sleep
from signal import pause

mc = minecraft.Minecraft.create()
led = gpiozero.RGBLED(red=21, green=20, blue=16)
button = gpiozero.Button(26)

class portalStateObject:
    
    oneDefined = False
    twoDefined = False
    
    # keeps track of the state of two portals.
    # try if (portalState.oneDefined): etc
    def __init__(self):
        self.oneDefined = False
        self.twoDefined = False
    
    def setPortal(self, portalNumber, trueOrFalse):
        if (portalNumber == 1):
            self.oneDefined = trueOrFalse
        elif (portalNumber == 2):
            self.twoDefined = trueOrFalse
        else:
            raise ValueError("setPortal only accepts values for 1 or 2")

class portal:
    def __init__(self, thePortalNumber, theColor):
        self.portalNumber = thePortalNumber
        self.portalPosition = vec3.Vec3(0,0,0)
        self.color = theColor
        portalState.setPortal(self.portalNumber, False)
        self.portalAlert("Ready to create portal {}".format(self.portalNumber), theColor = 'white')
        
    def createPortal(self):
        # Create a portal at current position
        x,y,z = mc.player.getPos() # get current player position
        self.portalPosition = vec3.Vec3(x-2, y, z)
        mc.setBlock(self.portalPosition, block.GLOWSTONE_BLOCK.id ) # complete list of block types at https://www.stuffaboutcode.com/p/minecraft-api-reference.html
        self.portalAlert("{}: Created portal {}".format(self.color, self.portalNumber))
        
    def deleteThisPortal(self):
        # this would be useful
        pass
    
    def amIHere(self):
        x,y,z = mc.player.getPos()
        if (int(self.portalPosition.x - 1) <= int(x) <= int(self.portalPosition.x + 1) and
            int(self.portalPosition.y - 1) <= int(y) <= int(self.portalPosition.y + 1) and
            int(self.portalPosition.z - 1) <= int(z) <= int(self.portalPosition.z + 1 ) ):
            return(True)
        else:
            return(False)
        
    def goHere(self):
        # go to this portal
        mc.player.setPos(self.portalPosition.x + 2, self.portalPosition.y, self.portalPosition.z)
        self.portalAlert("Returned to portal {}".format(self.portalNumber), theColor = 'orange')
        
    def portalAlert(self, theMessage, theColor = 'tbd'):
        # message to chat, change LED to this portal color
        if (theColor == 'tbd'):
            theColor = self.color
        mc.postToChat(theMessage)
        led.pulse(on_color = Color(theColor))
    
# set up objects

portalState = portalStateObject() # create an object we can use to track portal state

portalOne = portal(1, "blue")
portalTwo = portal(2, "red")

def buttonHandler():
    if (not portalState.oneDefined):
        portalOne.createPortal()
        portalState.setPortal(1, True)
    elif (not portalState.twoDefined):
        portalTwo.createPortal()
        portalState.setPortal(2, True)
    else:
        portalOne.goHere()

button.when_pressed = buttonHandler

# start watching minecraft
while True:
    if (portalOne.amIHere()) : portalTwo.goHere()
    if (portalTwo.amIHere()) : portalOne.goHere()
    print("Here: {}, portalOne: {}, portalTwo: {}".format(mc.player.getPos(), portalOne.portalPosition, portalTwo.portalPosition) )
    sleep(1)
    
pause()