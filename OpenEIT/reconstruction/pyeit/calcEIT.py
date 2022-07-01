#!/usr/bin/python

""" Based on dynamic_jac example: 16 electrode solver """
# Called from matlab script

from __future__ import division, absolute_import, print_function

import numpy as np
import h5py
from mat4py import loadmat
import matplotlib.pyplot as plt

import mesh as mesh
from eit.utils import eit_scan_lines

import eit.jac as jac
from eit.interp2d import sim2pts


def plotEIT(inp_path, ref_path):

    eit_input = loadmat(inp_path)
    eit_input = np.array(eit_input['signal'])
    eit_ref = loadmat(ref_path)
    eit_ref = np.array(eit_ref['reference'])

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
    fig.colorbar(im)
    ax.set_aspect('equal')
    plt.savefig("OpenEIT/reconstruction/pyeit/temp/outputimg.png", dpi=96)


plotEIT('OpenEIT/reconstruction/pyeit/temp/response.mat', 'OpenEIT/reconstruction/pyeit/temp/reference.mat')

