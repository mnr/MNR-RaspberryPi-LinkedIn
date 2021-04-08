from gpiozero import Button

button = Button(16)

while True:
    if button.is_pressed:
        print("button is pressed")
    else:
        print("button is not pressed")
        
        