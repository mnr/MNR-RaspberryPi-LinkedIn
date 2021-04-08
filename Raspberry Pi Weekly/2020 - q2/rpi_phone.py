# Raspberry Pi to a Rotary Phone

from gpiozero import Button
import time
from signal import pause

phone_dial_working = Button(14) # white wire to dial
phone_dial_rotor = Button(15) # blue wire to dial
phone_hook = Button(18) # brown wire to hook

def phone_hook_down():
    print("phone back in cradle")
    
def phone_hook_lifted():
    print("phone lifted from cradle")

def phone_dial_active():
    if phone_hook.value == 1:
        #print("dial has been turned")
        rotor_value = 0
        rotor_cumulative = 0
        while phone_dial_working.value == 1:
            # the rotor is moving
            if rotor_value != phone_dial_rotor.value:
                rotor_value = phone_dial_rotor.value
                print(rotor_value, time.time())
                rotor_cumulative = rotor_cumulative + rotor_value
        if (rotor_cumulative == 11):
            rotor_cumulative = 1
        print("You dialed:",rotor_cumulative - 1)
        
    
phone_hook.when_pressed = phone_hook_lifted
phone_hook.when_released = phone_hook_down
phone_dial_working.when_pressed = phone_dial_active

pause()