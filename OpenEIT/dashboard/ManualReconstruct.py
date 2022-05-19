from controller import *
import numpy as np

controller = Controller()
controller.configure()  # Defaults to 16 electrode case: Gives triangular mesh of circle with 363 nodes

# Use extracted responses from matlab saved as numpy array. Size 20000x192
responses = np.load("C:/Users/dshar/OneDrive - University of Cambridge/Documents/PhD/EIT/responses/responses.npy")

# Save as individual files which are combined in matlab
for i in range(10000):
    data1 = responses[2*i]
    data2 = responses[2*i + 1]
    controller.image_reconstruct.single_run(data1, data2, i)  # added method to worker.py dsh46 19/04/22
