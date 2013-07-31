#!/usr/bin/env python

from hih6130 import HIH6130
import smbus
import time
from datetime import datetime

logfile="temp_log.csv"
dateformat="%Y-%m-%dT%H:%M:%S"

#####

hih=HIH6130(smbus.SMBus(1))

with open(logfile, 'a') as log:
    print "Opening log %s" % logfile
    while(True):
	result=hih.read()
        now_string = datetime.now().strftime(dateformat)
	log.write("\"%s\", %0.2f, %0.2f\n" % (now_string, result[0], result[1]))
	log.flush()
	time.sleep(10)
