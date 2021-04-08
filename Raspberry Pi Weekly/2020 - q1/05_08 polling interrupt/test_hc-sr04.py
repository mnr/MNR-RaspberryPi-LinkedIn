from gpiozero import DistanceSensor

dsense = DistanceSensor(echo = 24, trigger = 18)

while True:
    print("Distance: ", dsense.distance)