import time
from smbus import SMBus

class HIH6130:
    """An SMBus interface to a HIH-6130 module

    This module communicates with a HIH-6130 temperature and humidity
    sensor over SMBus.

    To use, provide an instance of the SMBus that the device is
    connected to.

    >>> hih=HIH6130(SMBus(1))
    >>> result = hih.read()
    >>> temp = result[0]
    >>> humidity = result[1]

    Note: technically the chip speaks i2c and SMBus doesn't actually support
    the block read that's needed. As such, it actually performs two
    measurements per read request and the status code is always wrong."""

    addr = 0x27 # the standard address on the bus

    def __init__(self, bus):
        """Create a new instance using the given SMBus"""
	self.bus = bus

    def read(self):
	"""Reads from the sensor, blocking briefly.

        To read the sensor, a measurement request is first made.

        This returns a tuple of (humidity, temperature, status)
	where humidity is relative humidity in percentage and temperature is
	degrees Celsius."""

	# Send a measurement request
	self.bus.write_quick(self.addr)
	# allow time for the conversion
	time.sleep(0.050)
	# This, technically, sends an incorrect command. This issues an additional
	# measurement request, which causes the sensor to make another reading. As
	# the write is built into this, there is no delay and thus the result is
	# considered stale. The result it returns, however, is from moments ago so
	# it's fine.
	val = self.bus.read_i2c_block_data( 0X27, 0, 4)

	# Status is 2 bits
	status = val[0] >> 6

	# humidity is 14 bits, between 0 and 100%
	humidity_d = ((val[0] & (2**6-1)) << 8 )+ val[1]
	humidity = (humidity_d / (2**14-1.0)) * 100

	# temperature is 14 bits, between -40 and 125 deg C
	temperature_d = (val[2] << 6) + (val[3] >> 2)
	temperature = (temperature_d / (2**14-1.0)) * 165 - 40

	return (humidity, temperature, status)

# demo time!
if __name__ == '__main__':
    hih=HIH6130(SMBus(1))
    result = hih.read()
    print "humidity:\t%0.2f%%" % result[0]
    print "temperature:\t%0.2fC" % result[1]
    print "status:\t%d (this is always stale. see source)" % result[2]
