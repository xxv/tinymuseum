#!/usr/bin/env python

class Command(object):
    def __init__(self, code, data= []):
        self.code = code
        self.data = data

class TracerSerial(object):
    comm_init = [0xAA, 0x55] * 3 + [0xEB, 0x90] * 3

    def __init__(self, tracer, port):
        self.tracer = tracer
        self.port = port

    def to_bytes(self, command):
        cmd_data = tracer.get_command_bytes(command) + [0x00, 0x00, 0x7F]
        self.tracer.add_crc(cmd_data)
        to_send = self.comm_init + cmd_data

        return to_send

class Tracer(object):
    def __init__(self, controller_id):
        self.controller_id = controller_id

    def get_command_bytes(self, command):
        data = []
        data.append(self.controller_id)
        data.append(command.code)
        data.append(len(command.data))
        data += command.data

        return data

    def add_crc(self, data):
        crc = self.crc(data, data[2] + 5)
        data[data[2] + 3] = crc >> 8
        data[data[2] + 4] = crc & 0xFF

        return data

    def crc(self, data, crc_len):
        i = j = r1 = r2 = r3 = r4 = 0
        result = 0

        r1 = data[0]
        r2 = data[1]
        crc_buff = 2

        for i in range(0, crc_len - 2):
            r3 = data[crc_buff]
            crc_buff += 1

            for j in range(0, 8):
                r4 = r1
                r1 = (r1 * 2) & 0xFF;

                if r2 & 0x80:
                    r1 += 1
                r2 = (r2 * 2) & 0xFF;

                if r3 & 0x80:
                    r2 += 1
                r3 = (r3 * 2) & 0xFF;

                if r4 & 0x80:
                    r1 ^= 0x10
                    r2 ^= 0x41

        result = (r1 << 8) | r2

        return result


data = [0x16, 0xA0, 0x00, 0x00, 0x00, 0x7F]

tracer = Tracer(0x16)

tracer.add_crc(data)


serial = TracerSerial(tracer, "")
print serial.comm_init, data
query = Command(0xA0)
print serial.to_bytes(query)

