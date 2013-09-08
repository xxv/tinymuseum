#!/usr/bin/env python

from hih6130 import HIH6130
import smbus
import time
from datetime import datetime

import re

logfile="temp_log.csv"
dateformat="%Y-%m-%dT%H:%M:%S"

web_page="/var/www/index.html"

#####

hih=HIH6130(smbus.SMBus(1))

tag_match=re.compile("{{\s*(\w+)\s*}}")
def fill_in_parameters(templ, tags):
    def match_replace(match):
        tag = match.group(1)
        return str(tags[tag])
    return re.sub(tag_match, match_replace, templ)

template=None
with open("template.html") as template_file:
    template="".join(template_file.readlines())

with open(logfile, 'a') as log:
    print "Opening log %s" % logfile
    while(True):
	result=hih.read()
        now_string = datetime.now().strftime(dateformat)
	log.write("\"%s\", %0.2f, %0.2f\n" % (now_string, result[0], result[1]))
	log.flush()
        with open(web_page, 'w') as web:
            web.write(fill_in_parameters(template, {"temperature": "%0.2f" % result[1], "humidity": "%0.2f" % result[0]}))
	time.sleep(10)
