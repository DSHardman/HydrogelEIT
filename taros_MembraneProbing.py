import waypoints as wp
import kg_robot as kgr
import time
import numpy as np
import random
import serial
import queue

zeropose = [0.631659, -0.0907919, 0.0472855, 3.11325, -0.294326, 0.0483286]

# #  Connect to UR5
urnie = kgr.kg_robot(port=30010, db_host="169.254.150.50")
urnie.set_tcp(wp.probing_tcp)

# # Connect to EIT board
com = "COM3"
ser = serial.Serial(port=com, baudrate=9600)


def pressrecord(x, y, depth, savestring):
    xy = [x, y, depth]

    # # Control press using defined variables
    startingpose = np.add(zeropose, [x, y, 0.01, 0, 0, 0])
    urnie.movel(startingpose, acc=0.02, vel=0.02)


    f = open('responses/taros/up.txt', "a")
    for i in range(10):
        f.write(str(ser.readline()))
        f.write('\n')
    f.close()

    downpose = np.add(zeropose, [x, y, -depth, 0, 0, 0])
    urnie.movel(downpose, acc=0.01, vel=0.01)
    time.sleep(2)

    np.save('responses/taros/position' + savestring, xy)

    f = open('responses/taros/down.txt', "a")
    for i in range(10):
        f.write(str(ser.readline()))
        f.write('\n')
    f.close()

    urnie.movel(startingpose, acc=0.01, vel=0.01)


for i in range(1000):  # Randomise within circle

    radius = 65

    # Select from random distribution within circle
    rho = radius*2
    while rho > radius:
        x = (random.random()*2*radius-radius)/1000
        y = (random.random()*2*radius-radius)/1000
        rho = np.sqrt((x*1000)**2 + (y*1000)**2)

    depth = random.choice([0.01, 0.015, 0.02])
    pressrecord(x, y, depth, '_taros_' + str(i))
    print(i)

urnie.close()
