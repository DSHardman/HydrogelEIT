""" Based on dynamic_jac example: 16 electrode solver """
from __future__ import division, absolute_import, print_function

import numpy as np
import pickle
import matplotlib.pyplot as plt

import mesh as mesh
from eit.utils import eit_scan_lines

import eit.jac as jac
from eit.interp2d import sim2pts


def plotEIT(inp_path, ref_path, num):

    eit_input = np.load(inp_path)
    eit_ref = np.load(ref_path)

    """ 0. construct mesh """
    mesh_obj, el_pos = mesh.create(16, h0=0.1)
    # mesh_obj, el_pos = mesh.layer_circle()

    # extract node, element, alpha
    pts = mesh_obj['node']
    tri = mesh_obj['element']
    x, y = pts[:, 0], pts[:, 1]

    mesh_obj['alpha'] = np.random.rand(tri.shape[0]) * 200 + 100

    """ FEM simulation """
    el_dist, step = 8, 1
    ex_mat = eit_scan_lines(16, el_dist)

    """ JAC solver """
    # Note: if the jac and the real-problem are generated using the same mesh,
    # then, jac_normalized in JAC and data normalization in solve are not needed.
    # However, when you generate jac from a known mesh, but in real-problem
    # (mostly) the shape and the electrode positions are not exactly the same
    # as in mesh generating the jac, then JAC and data must be normalized.
    eit = jac.JAC(mesh_obj, el_pos, ex_mat=ex_mat, step=step,
                  perm=1., parser='std')
    eit.setup(p=0.5, lamb=0.01, method='kotre')

    ds = eit.solve(eit_input, eit_ref, normalize=True)
    ds_n = sim2pts(pts, tri, np.real(ds))

    # plot EIT reconstruction
    fig, ax = plt.subplots(figsize=(6, 4))
    im = ax.tripcolor(x, y, tri, ds_n, shading='flat')
    for i, e in enumerate(el_pos):
        ax.annotate(str(i+1), xy=(x[e], y[e]), color='r')
    #im.set_clim(vmin=-0.1, vmax=0.1)
    fig.colorbar(im)
    ax.set_aspect('equal')
    #fig.set_size_inches(6, 4)
    plt.savefig("healcutcomp"+str(num)+".png", dpi=96)
    #plt.show()

# plotEIT("responses/up_cut1_0.npy", "responses/up_repeat_9.npy", 2)
# plotEIT("responses/up_heal1_0.npy", "responses/up_cut1_14.npy", 2)
for i in range(15):
    plotEIT("responses/down_heal1_"+str(i)+".npy", "responses/down_cut1_"+str(i)+".npy", i)


# for i in range(10):
#     plotEIT("responses/down_repeatheal_"+str(i)+".npy", "responses/up_repeatheal_"+str(i)+".npy", i)
