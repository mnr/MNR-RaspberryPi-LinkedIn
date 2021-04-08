# Adafruit io example for Raspberry Pi Weekly

from Adafruit_IO import Client, RequestError, Feed
from adafruit_keys import ADAFRUIT_IO_USERNAME, ADAFRUIT_IO_KEY # create this with information from your adafruit IO key
from gpiozero import CPUTemperature
import time

# connect to adafruit.io
adafruit_io = Client(ADAFRUIT_IO_USERNAME, ADAFRUIT_IO_KEY)

# learn a bit about available feeds
feeds = adafruit_io.feeds()
print(feeds)

# create a feed for rpiTempFeed
# Heads up - feed keys are lower case
try:
    rpiTempFeed = adafruit_io.feeds('rpitemperature')
except RequestError:
    adafruit_feed = Feed(name = "rpitemperature")
    rpiTempFeed = adafruit_io.create_feed(adafruit_feed)

# send the CPU temperature to Adafruit.io
while True:
    adafruit_io.send_data(rpiTempFeed.key, CPUTemperature().temperature )
    print("sending temp:", CPUTemperature().temperature)
    time.sleep(10)





