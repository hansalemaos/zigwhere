import cython
cimport cython
import os
import numpy as np
cimport numpy as np
import time, subprocess
from libcpp.string cimport string
from libcpp.unordered_map cimport unordered_map
import ctypes
import re
import platform
this_folder = os.path.dirname(__file__)
_func_cache = []
subprocess._USE_VFORK = False
subprocess._USE_POSIX_SPAWN = False
iswindows = "win" in platform.platform().lower()
if iswindows:
    addtolist = []
else:
    addtolist = ["&"]


def compile_it(ziglibfile):
    zigpathstr = os.path.normpath(os.path.join(this_folder, ziglibfile))
    winpathstr = re.sub(r'\.zig$','.dll',zigpathstr)
    linuxpathstr = re.sub(r'\.zig$','.so',zigpathstr)
    win_path=os.path.exists(winpathstr)
    linux_path=os.path.exists(linuxpathstr)
    if not os.path.exists(winpathstr) and not os.path.exists(winpathstr) :
        old_folder=os.getcwd()
        os.chdir(this_folder)
        subprocess.run(
        ["zig", "build-lib", ziglibfile, "-dynamic",'-lc', "-O", "ReleaseFast"]+addtolist,
        shell=True,
        env=os.environ,
        preexec_fn=None
        if iswindows
        else os.setpgrp
        if hasattr(os, "setpgrp")
        else None,
        )
        time.sleep(1)
        if not iswindows:
            time.sleep(20)
        win_path=os.path.exists(winpathstr)
        linux_path=os.path.exists(linuxpathstr)
        os.chdir(old_folder)
    if win_path:
        return winpathstr
    if linux_path:
        return linuxpathstr
    raise OSError('Zig library not found')

ziglibfile='zignpwhere.zig'
library_path_string=compile_it(ziglibfile)

ctypedef void (*pure_zigc_function)(size_t array_address, size_t search_for, size_t array_len, size_t callback_fu, size_t result_vector, size_t operation, size_t address_np_shape, size_t np_shape_len ) noexcept nogil

ctypedef unordered_map[string, pure_zigc_function] functiondict

ctypedef fused fusednumbers:
    np.npy_byte
    np.npy_ubyte
    np.npy_short
    np.npy_ushort
    np.npy_int
    np.npy_uint
    np.npy_long
    np.npy_ulong
    np.npy_longlong
    np.npy_ulonglong
    np.npy_intp
    np.npy_uintp
    np.npy_float
    np.npy_double
    np.npy_longdouble

cdef functiondict get_lookup_dict(str dllpathstr,dict function_dict_names):
    cdef:
        functiondict zig_functions
    cta = ctypes.cdll.LoadLibrary(dllpathstr)
    _func_cache.append(cta)
    for dtypechar,zigfunction in function_dict_names.items():
        ctypes_f=getattr(cta, zigfunction)
        zig_functions[dtypechar]=(<pure_zigc_function*><size_t>ctypes.addressof(ctypes_f))[0]
    return zig_functions

cdef:
    dict[str,str] function_dict_names={
        "i":"np_zig_where_c_int",
        "l":"np_zig_where_c_int",
        "L":"np_zig_where_c_uint",
        "I":"np_zig_where_c_uint",
        "b":"np_zig_where_c_char",
        "B":"np_zig_where_u8",
        "h":"np_zig_where_c_short",
        "H":"np_zig_where_c_ushort",
        "q":"np_zig_where_c_longlong",
        "Q":"np_zig_where_c_ulonglong",
        "f":"np_zig_where_f32",
        "d":"np_zig_where_f64",
        "D":"np_zig_where_f128",
        }
    functiondict zig_functions = get_lookup_dict(
                                dllpathstr=library_path_string,
                                function_dict_names=function_dict_names)

cpdef np.ndarray np_where_zig(fusednumbers[:] array_view, fusednumbers[:] search_for_view, tuple array_shape, str dtype_char, size_t operation):
    cdef:
        string byte_type=dtype_char
        size_t array_len =array_view.shape[0]
        np.ndarray[np.npy_uintp, ndim=1, mode="c", cast=False] array_shapenp_full = np.array(array_shape,dtype=np.uint64)
        size_t[:] array_shapenp = array_shapenp_full
        size_t len_of_numpy_shape_array = len(array_shape)
        np.ndarray[np.npy_uintp, ndim=1, mode="c", cast=False] max_counter_full =np.zeros(1,dtype=np.uint64)
        size_t[:] max_counter = max_counter_full
        np.ndarray[np.npy_uintp, ndim=1, mode="c", cast=False] result_vector_full = np.empty((array_len*len_of_numpy_shape_array),dtype=np.uint64)
        size_t[:] result_vector=result_vector_full
    zig_functions[byte_type](
        <size_t>&array_view[0],
        <size_t>&search_for_view[0],
        array_len,
        <size_t>&max_counter[0],
        <size_t>&result_vector[0],
        operation,
        <size_t>&array_shapenp[0],
        len_of_numpy_shape_array
    )
    return np.flip(result_vector_full[:max_counter[0]*len_of_numpy_shape_array].reshape((-1,len_of_numpy_shape_array)),1)