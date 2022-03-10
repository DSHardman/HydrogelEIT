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
timepressed = 2
dt = 0.05

xupperbound = 130 * 0.001
yupperbound = 60 * 0.001

samplesdown = int(timedown/dt)

zeropose = [0.0223994, -0.489636, 0.0102109, -3.11974, -0.110339, 0.041454]


#  Connect to UR5
urnie = kgr.kg_robot(port=30010, db_host="169.254.150.50")
urnie.set_tcp(wp.probing_tcp)

# Connect to EIT board
#ser = serial.Serial(port="COM3", baudrate=115200, timeout=10)
serial_handler = OpenEIT.backend.SerialHandler(queue.Queue())
serial_handler.connect('COM3')
serial_handler.setmode('d')
serial_handler.start_recording()
time.sleep(20)  # Give ample time to connect and start returning data

for i in range(10000):  # Record 10000 probes

    # Random xy positions & depth
    x = random.random()*xupperbound
    y = random.random()*yupperbound
    depth = random.choice([0.002, 0.004, 0.006])
    xy = [x, y, depth]

    # Control press using defined variables
    startingpose = np.add(zeropose, [x, y, 0.01, 0, 0, 0])
    urnie.movel(startingpose, acc=0.02, vel=0.02)

    poses = 0
    poses = np.ones((int((timebefore+timedown)/dt), 1))*startingpose

    for j in range(int(timebefore/dt), int(timebefore/dt) + samplesdown):
        poses[j] = np.add(poses[j], [0, 0, -(depth+0.01)*(j - int(timebefore/dt))/samplesdown, 0, 0, 0])

    urnie.movel(poses[0], acc=0.02, vel=0.02)

    # Measure and record sensor data
    urnie.movel(poses[0], acc=0.02, vel=0.02)
    t0 = time.time()
    for k in range(0, int((timebefore+timedown)/dt)):
        urnie.servoj(poses[k], control_time=dt, lookahead_time=0.2)
        while time.time() - t0 < dt*(k+1):
            continue

    # Save data
    # data = ser.readline()
    serial_state = serial_handler.updater
    while serial_handler.updater == serial_state:
        pass  # wait for last set of readings to end

    while serial_handler.updater != serial_state:
        pass  # wait for new set of readings to end

    data = OpenEIT.backend.serialhandler.parse_any_line(serial_handler.raw_text, 'd')

    np.save('responses/position' + str(i), xy)
    np.save('responses/response' + str(i), data)
    # f = open('responses/response' + str(i) + '.txt', "w")
    # f.write(str(xy[0]) + ", " + str(xy[1]) + ", " + str(xy[2]) + "\n")
    # f.write(str(data))
    # f.close()

    urnie.movel(startingpose, acc=0.02, vel=0.02)

    print(i)

urnie.close()
