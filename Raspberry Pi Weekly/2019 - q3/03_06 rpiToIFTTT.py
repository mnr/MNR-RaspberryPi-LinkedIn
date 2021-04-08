# Trigger a IFTTT request

# values for you to fill in...
myIFTTTkey = "something_like_djb5CRDZFwDmb37IZZPXka" # get this from IFTTT
myEvent = "the event you created" # Look between "/trigger/" and "/with/"
myValue1 = "This" # optional values
myValue2 = "That"
myValue3 = "Another"

# information built up from the information you filled in above this line...
triggerURL = "https://maker.ifttt.com/trigger/" + myEvent + "/with/key/" + myIFTTTkey
allValues = {'value1': myValue1, 'value2': myValue2, 'value3': myValue3}

# this triggers the IFTTT event
import requests
# the following is the line of code to run on an event.
ISentThis = requests.post(triggerURL, data = allValues)

# as an example, here is a GPIO pushbutton event
# def triggerIFTTT():
#    ISentThis = requests.post(triggerURL, data = allValues)
    
# button.when_pressed = triggerIFTTT

