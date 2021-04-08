# MQTT Client for LinkedIn Learning Raspberry Pi Weekly
from gpiozero import LED
import paho.mqtt.subscribe as subscribe

myLED = LED(26)
broker_location = "mqtt.eclipse.org"

def on_mqtt_message(client, userdata, message):
    print(message.topic + " " +str(message.payload))
    if ("is ON" in str(message.payload)):
        myLED.on()
        print("MQTT says to turn the LED on")
    else:
        myLED.off()
        print("Any other MQTT message will turn the LED off")

subscribe.callback(on_mqtt_message, "LinkedInLearning/rpiweekly", hostname = broker_location)
