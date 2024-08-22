from __future__ import annotations
import numpy as np

try:
    import npzigwhere

except Exception as e:
    import Cython, setuptools, platform, subprocess, os, sys, time

    iswindows = "win" in platform.platform().lower()
    if iswindows:
        addtolist = []
    else:
        addtolist = ["&"]

    olddict = os.getcwd()
    dirname = os.path.dirname(__file__)
    os.chdir(dirname)
    compile_file = os.path.join(dirname, "npzigwhere_compile.py")
    subprocess._USE_VFORK = False
    subprocess._USE_POSIX_SPAWN = False
    subprocess.run(
        " ".join([sys.executable, compile_file, "build_ext", "--inplace"] + addtolist),
        shell=True,
        env=os.environ,
        preexec_fn=None
        if iswindows
        else os.setpgrp
        if hasattr(os, "setpgrp")
        else None,
    )
    if not iswindows:
        time.sleep(30)
    import npzigwhere

    os.chdir(olddict)


def _npzigargwhere(
    op,
    a,
    v,
):
    return npzigwhere.np_where_zig(
        a.ravel(), np.require([v], dtype=a.dtype), a.shape, a.dtype.char, op
    )
def _npzigwhere(
    op,
    a,
    v,
):
    return tuple(npzigwhere.np_where_zig(
        a.ravel(), np.require([v], dtype=a.dtype), a.shape, a.dtype.char, op
    ).T)


def zig_argwhere_lt(
    a,
    v,
):
    return _npzigargwhere(0, a, v)


def zig_argwhere_le(
    a,
    v,
):
    return _npzigargwhere(1, a, v)


def zig_argwhere_eq(
    a,
    v,
):
    return _npzigargwhere(2, a, v)


def zig_argwhere_ge(
    a,
    v,
):
    return _npzigargwhere(3, a, v)


def zig_argwhere_gt(
    a,
    v,
):
    return _npzigargwhere(4, a, v)


def zig_where_lt(
    a,
    v,
):
    return _npzigwhere(0, a, v)


def zig_where_le(
    a,
    v,
):
    return _npzigwhere(1, a, v)


def zig_where_eq(
    a,
    v,
):
    return _npzigwhere(2, a, v)


def zig_where_ge(
    a,
    v,
):
    return _npzigwhere(3, a, v)


def zig_where_gt(
    a,
    v,
):
    return _npzigwhere(4, a, v)
