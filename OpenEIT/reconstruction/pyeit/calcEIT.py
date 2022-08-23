#!/usr/bin/python

""" Based on dynamic_jac example: 16 electrode solver """
# Called from matlab script

from __future__ import division, absolute_import, print_function

import sys

import numpy as np
#import h5py
from mat4py import loadmat
import matplotlib.pyplot as plt

import mesh as mesh
from eit.utils import eit_scan_lines

import eit.jac as jac
import eit.bp as bp
import eit.greit as greit
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

    """ FEM simulation """
    el_dist, step = 8, 1
    ex_mat = eit_scan_lines(16, el_dist)

    if sys.argv[1] == 'jac':
        """ JAC solver """
        # Note: if the jac and the real-problem are generated using the same mesh,
        # then, jac_normalized in JAC and data normalization in solve are not needed.
        # However, when you generate jac from a known mesh, but in real-problem
        # (mostly) the shape and the electrode positions are not exactly the same
        # as in mesh generating the jac, then JAC and data must be normalized.
        eit = jac.JAC(mesh_obj, el_pos, ex_mat=ex_mat, step=step,
                      perm=1., parser='std')
        eit.setup(p=0.5, lamb=0.01, method='kotre')
        # eit.setup(p=0.5, lamb=0.4, method='kotre') # Used for openEIT defaults
        ds = eit.solve(eit_input, eit_ref, normalize=True)
        ds = sim2pts(pts, tri, np.real(ds))
    elif sys.argv[1] == 'bp':
        """ BP solver """
        eit = bp.BP(mesh_obj, el_pos, ex_mat=ex_mat, step=1, parser='std')
        eit.setup(weight='none')
        ds = 192.0 * eit.solve(eit_input, eit_ref)
    elif sys.argv[1] == 'greit':
        """ GREIT solver """
        eit = greit.GREIT(mesh_obj, el_pos, ex_mat=ex_mat, step=step, parser='std')
        eit.setup(p=0.50, lamb=0.001)
        ds = eit.solve(eit_input, eit_ref)
        x, y, ds = eit.mask_value(ds, mask_value=np.NAN)
    else:
        raise Exception("Invalid Solver")

    # plot EIT reconstruction
    ds -= np.mean(ds)
    fig, ax = plt.subplots(figsize=(6, 4))
    if sys.argv[1] == 'greit':
        im = ax.imshow(np.rot90(np.fliplr(np.real(ds)), k=3), interpolation='none', cmap=plt.cm.viridis)
    else:
        # Reflect so electrode 0 is lowermost
        for i in range(0, len(x)):
            x2 = y[i]
            y[i] = x[i]
            x[i] = x2
        im = ax.tripcolor(x, y, tri, ds, cmap=plt.cm.viridis)
        #ax.tricontour(x, y, tri, ds, cmap=plt.cm.binary)

    # fig.colorbar(im)
    # im.set_clim(vmin=-1e7, vmax=1e7) # scale used for baseline animations
    ax.set_aspect('equal')
    plt.savefig("OpenEIT/reconstruction/pyeit/temp/outputimg.png", dpi=96)
    # plt.savefig("OpenEIT/reconstruction/pyeit/temp/outputimg.eps", format='eps')


plotEIT('OpenEIT/reconstruction/pyeit/temp/response.mat', 'OpenEIT/reconstruction/pyeit/temp/reference.mat')

