import waypoints as wp
import kg_robot as kgr
import time
import numpy as np
import random
import serial
#from __future__ import absolute_import
import queue
import OpenEIT.backend

timebefore = 1
timedown = 1.5
# timepressed = 2
dt = 0.05

# xupperbound = 130 * 0.001
# yupperbound = 60 * 0.001

# samplesdown = int(timedown/dt)

zeropose = [0.247722, -0.392591, 0.0388576, -3.12646, -0.125169, -0.0300251]


#  Connect to UR5
urnie = kgr.kg_robot(port=30010, db_host="169.254.150.50")
urnie.set_tcp(wp.probing_tcp)

# Connect to EIT board
serial_handler = OpenEIT.backend.SerialHandler(queue.Queue())
serial_handler.connect('COM4')
serial_handler.setmode('d')
serial_handler.start_recording()
time.sleep(20)  # Give ample time to connect and start returning data


def pressrecord(x, y, depth, savestring):
    xy = [x, y, depth]

    # Control press using defined variables
    startingpose = np.add(zeropose, [x, y, 0.01, 0, 0, 0])
    urnie.movel(startingpose, acc=0.02, vel=0.02)

    serial_state = serial_handler.updater
    while serial_handler.updater == serial_state:
        pass  # wait for last set of readings to end

    while serial_handler.updater != serial_state:
        pass  # wait for new set of readings to end

    data = OpenEIT.backend.serialhandler.parse_any_line(serial_handler.raw_text, 'd')

    np.save('responses/silicone/up' + savestring, data)

    downpose = np.add(zeropose, [x, y, -depth, 0, 0, 0])
    urnie.movel(downpose, acc=0.01, vel=0.01)

    # Save data
    serial_state = serial_handler.updater
    while serial_handler.updater == serial_state:
        pass  # wait for last set of readings to end

    while serial_handler.updater != serial_state:
        pass  # wait for new set of readings to end

    data = OpenEIT.backend.serialhandler.parse_any_line(serial_handler.raw_text, 'd')

    np.save('responses/silicone/position' + savestring, xy)
    np.save('responses/silicone/down' + savestring, data)

    urnie.movel(startingpose, acc=0.01, vel=0.01)


# for i in range(15):
#
#     # y line with 1cm depth
#     x = 0
#     y = (-70 + i*10)/1000
#     depth = 0.025
#     pressrecord(x, y, depth, '_linedeep_' + str(i))
#     print(i)

# for i in range(50000):  # Record 10000 probes
#
#     # y line with 1cm depth
#     x = 0
#     y = (random.random()*140-70)/1000
#     depth = 0.01
#     pressrecord(x, y, depth, '_doubleheal2_' + str(i))
#     print(i)

# for i in range(20000):  # Randomise within circle
#
#     radius = 70
#
#     # Select from random distribution within circle
#     rho = radius*2
#     while rho > radius:
#         x = (random.random()*2*radius-radius)/1000
#         y = (random.random()*2*radius-radius)/1000
#         rho = np.sqrt((x*1000)**2 + (y*1000)**2)
#
#     # depth = 0.01
#     depth = random.choice([0.005, 0.01, 0.015, 0.02])
#     pressrecord(x, y, depth, '_alldepths_' + str(i))
#     print(i)

namingstring = '_line_'
pressrecord(0, 0, 0.02, namingstring+'0')
pressrecord(-0.05, 0, 0.02, namingstring+'1')
pressrecord(0.05, 0, 0.02, namingstring+'2')
pressrecord(0, -0.05, 0.02, namingstring+'3')
pressrecord(0, 0.05, 0.02, namingstring+'4')

# for i in range(10):  # 10 central repeats
#     x = 0
#     y = 0
#     depth = 0.025
#     pressrecord(x, y, depth, '_repeathealdeep_' + str(i))
#     print(i)

urnie.close()
