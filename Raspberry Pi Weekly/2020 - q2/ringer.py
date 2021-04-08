# make the bell ring

from gpiozero import Buzzer

ringer = Buzzer(23)

ringer.beep(on_time = .04, off_time = .04, n = 20)


