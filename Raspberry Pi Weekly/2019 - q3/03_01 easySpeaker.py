from gpiozero import TonalBuzzer
from gpiozero.tones import Tone
import time
import random

myspeaker = TonalBuzzer(13)


while True:
    playThis = random.randint(220,880)
    print(playThis)
    myspeaker.play(Tone(playThis))
    time.sleep(.1)

    
while False:
    for playThis in range(220, 890, 10):
        print(playThis)
        myspeaker.play(Tone(playThis))
        time.sleep(.03)

myspeaker.stop()
