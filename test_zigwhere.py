from numpyzigwhere import (
    zig_where_lt,
    zig_where_le,
    zig_where_eq,
    zig_where_ge,
    zig_where_gt,
    zig_argwhere_lt,
    zig_argwhere_le,
    zig_argwhere_eq,
    zig_argwhere_ge,
    zig_argwhere_gt,
)
import numpy as np

shape = (
    1000,
    1000,
    10,

)

c = np.random.randint(0, 256, np.prod(shape), dtype="i").reshape(shape).astype("i").copy()

no = 128
print("--------------------------------------------")
reszig_0 = zig_where_eq(c, no)
print(reszig_0)
resnp_0=np.where(c == no)
resnp_0_stack=np.dstack(np.where(c == no)).squeeze()
print(resnp_0_stack)
print('--------------------------------------------')
reszig_1 = zig_where_lt(c, no)
print(reszig_1)
resnp_1 = np.where(c < no)
resnp_1_stack = np.dstack(np.where(c < no)).squeeze()
print(resnp_1_stack)
print("--------------------------------------------")

reszig_2 = zig_where_le(c, no)
print(reszig_2)
resnp_2 = np.where(c <= no)
resnp_2_stack = np.dstack(np.where(c <= no)).squeeze()
print(resnp_2_stack)
print("--------------------------------------------")
reszig_3 = zig_where_ge(c, no)
print(reszig_3)
resnp_3 = np.where(c >= no)
resnp_3_stack = np.dstack(np.where(c >= no)).squeeze()
print(resnp_3_stack)

print("--------------------------------------------")
reszig_4 = zig_where_gt(c, no)
print(reszig_4)
resnp_4 = np.where(c > no)
resnp_4_stack = np.dstack(np.where(c > no)).squeeze()
print(resnp_4_stack)
print("--------------------------------------------")

resnp_1ta = np.where(c.ravel() < no)
len_of_numpy_shape_array=len(c.shape)
var_get_out_0 = resnp_1ta[0][-1]
result_indicies_np = np.zeros((1, len(c.shape)), dtype=np.int64)
var_get_out_1 = 0
var_stays = 0
i=0
picshapenp=np.array(c.shape, dtype=np.int64)
picshape_reverse=np.arange(len_of_numpy_shape_array - 1, -1, -1, dtype=np.int64)
for shape_index in range(len(c.shape)):
    var_get_out_1=var_get_out_0//picshapenp[picshape_reverse[shape_index]]
    var_stays = var_get_out_0 % picshapenp[picshape_reverse[shape_index]]
    var_get_out_0 = var_get_out_1
    result_indicies_np[i, len(c.shape) - shape_index - 1] = var_stays
    print(result_indicies_np)
print(result_indicies_np)
#print(res1)


"""
print("lt")
%timeit res6 = np.where(c < no)
%timeit res1 = npzigwhere_lt(c, no)

print("le")
%timeit res7 = np.where(c <= no)
%timeit res2 = npzigwhere_le(c, no)

print("eq")
%timeit res8 = np.where(c == no)
%timeit res3 = npzigwhere_eq(c, no)

print("ge")
%timeit res9 = np.where(c >= no)
%timeit res4 = npzigwhere_ge(c, no)

print("gt")
%timeit res10 = np.where(c > no)
%timeit res5 = npzigwhere_gt(c, no)

"""
