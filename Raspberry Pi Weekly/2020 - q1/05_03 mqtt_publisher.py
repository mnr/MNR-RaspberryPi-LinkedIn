from gpiozero import Button
from signal import pause
import paho.mqtt.publish as publish
import datetime

mybutton = Button(4)
broker_location = "mqtt.eclipse.org"

def mqtt_pub(PassedSwitch):
    # mybutton is passed to this function by "when_pressed"
    timeNow = datetime.datetime.now().strftime("%H:%M:%S")
    if (PassedSwitch.is_pressed):
        mqttMessage = "At {} MQTT publisher is ON".format(timeNow)
        print("Sending mqtt message: Pressed")
    else:
        mqttMessage = "At {} MQTT publisher is OFF".format(timeNow)
        print("Sending mqtt message: Not Pressed")

    publish.single("LinkedInLearning/rpiweekly", mqttMessage, hostname = broker_location)


# test the mqtt loop
publish.single("LinkedInLearning/rpiweekly", "Initial MQTT Message", hostname = broker_location)


# then watch the button
mybutton.when_pressed = mqtt_pub

mybutton.when_released = mqtt_pub

pause()
