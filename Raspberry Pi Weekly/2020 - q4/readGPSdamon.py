#! /usr/bin/python

# credit to ozzmaker.com
# gps attributes at https://gpsd.gitlab.io/gpsd/gpsd_json.html
 
from gps import *
import time
    
gpsd = gps(mode=WATCH_ENABLE|WATCH_NEWSTYLE) 
template = "{0:14}\t{1:15}\t{2:10}\t{3:10}"
print (template.format("Latitude","Longitude", "Altitude", "Time") )

try:
    while True:
        report = gpsd.next() 
        if report['class'] == 'TPV':

            print (template.format(getattr(report,'lat',0.0),
                                   getattr(report,'lon',0.0),
                                   getattr(report,'alt','nan'),
                                   getattr(report, 'time', " ")
                                   )
                   )
            time.sleep(1) 
 
except (KeyboardInterrupt, SystemExit): #when you press ctrl+c
    print ("Done.\nExiting.")