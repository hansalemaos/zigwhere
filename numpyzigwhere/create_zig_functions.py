import os
this_folder = os.path.dirname(__file__)
zigoutput = os.path.join(this_folder, "zignpwhere.zig")
zigfunction = "np_zig_where"
functionheader = r"""const std = @import("std");
//const allocator = std.heap.c_allocator;
extern fn malloc(usize) callconv(.C) ?[*]usize;
extern fn free([*]usize) callconv(.C) void;
//const save_my_results = *const fn (flat_index: usize, result_vector: usize, found_results: usize) void;

fn convert2np(result_vector: usize, callback_fu: usize, address_np_shape: usize, np_shape_len: usize, counter: usize, ptr: [*]usize) void {
    @setFloatMode(.optimized);
    const ptrresults: [*]usize = @ptrFromInt(result_vector);
    const ptrint: [*]usize = @ptrFromInt(callback_fu);
    var var_get_out_0: usize = 0;
    var var_get_out_1: usize = 0;
    const pointer_np_shape: [*]usize = @ptrFromInt(address_np_shape);
    const len_of_numpy_shape_array_minus_1: usize = np_shape_len - 1;
    var ptrresultscounter: usize = 0;
    ptrint[0] = counter;
    for (0..counter) |i| {
        var_get_out_0 = ptr[i];
        for (0..np_shape_len) |shape_index| {
            var_get_out_1 = @divFloor(var_get_out_0, pointer_np_shape[len_of_numpy_shape_array_minus_1 - shape_index]);
            ptrresults[ptrresultscounter] = @mod(var_get_out_0, pointer_np_shape[len_of_numpy_shape_array_minus_1 - shape_index]);
            ptrresultscounter += 1;
            var_get_out_0 = var_get_out_1;
        }
    }
}

"""
# FUNCTIONZIG_DATATYPEZIG
# const thisdtype = [*]DATATYPEZIG;
# const thisdtype_no_pointer = DATATYPEZIG;

zigfuncraw = R"""export fn FUNCTIONZIG_DATATYPEZIG(array_address: usize, search_for: usize, array_len: usize, callback_fu: usize, result_vector: usize, operation: usize, address_np_shape: usize, np_shape_len: usize) ?*void {
    const thisdtype = [*]DATATYPEZIG;
    const thisdtype_no_pointer = DATATYPEZIG;
    const pointer_address_of_numpy_array: thisdtype = @ptrFromInt(array_address);
    const pointer_value_to_search_for: thisdtype = @ptrFromInt(search_for);
    const real_value_to_search_for: thisdtype_no_pointer = pointer_value_to_search_for[0];
    var counter: usize = 0;
    const ptr = malloc(array_len * @sizeOf(usize)) orelse return null;
    defer free(ptr);

    if (operation == 0) {
        for (0..array_len) |flat_index| {
            if (pointer_address_of_numpy_array[flat_index] < real_value_to_search_for) {
                ptr[counter] = flat_index;
                counter += 1;
            }
        }
    } else if (operation == 1) {
        for (0..array_len) |flat_index| {
            if (pointer_address_of_numpy_array[flat_index] <= real_value_to_search_for) {
                ptr[counter] = flat_index;
                counter += 1;
            }
        }
    } else if (operation == 2) {
        for (0..array_len) |flat_index| {
            if (pointer_address_of_numpy_array[flat_index] == real_value_to_search_for) {
                ptr[counter] = flat_index;
                counter += 1;
            }
        }
    } else if (operation == 3) {
        for (0..array_len) |flat_index| {
            if (pointer_address_of_numpy_array[flat_index] >= real_value_to_search_for) {
                ptr[counter] = flat_index;
                counter += 1;
            }
        }
    } else if (operation == 4) {
        for (0..array_len) |flat_index| {
            if (pointer_address_of_numpy_array[flat_index] > real_value_to_search_for) {
                ptr[counter] = flat_index;
                counter += 1;
            }
        }
    }
    convert2np(result_vector, callback_fu, address_np_shape, np_shape_len, counter, ptr);
    return null;
}

    """
zigdatatypes = [
    "c_int",
    "c_int",
    "c_uint",
    "c_uint",
    "c_char",
    "u8",
    "c_short",
    "c_ushort",
    "c_longlong",
    "c_ulonglong",
    "f32",
    "f64",
    "f128",
]
numpy_short_dtypes = [
    "i",
    "l",
    "L",
    "I",
    "b",
    "B",
    "h",
    "H",
    "q",
    "Q",
    "f",
    "d",
    "D",
]

allfunctions = {}
# from rich import print
for zigdatatype, numpy_short_dtype in zip(zigdatatypes, numpy_short_dtypes):
    zigfuncdtyped = zigfuncraw.replace("DATATYPEZIG", zigdatatype).replace(
        "FUNCTIONZIG", zigfunction
    )
    allfunctions[numpy_short_dtype] = {
        "funcname": zigfunction + "_" + zigdatatype,
        "func": zigfuncdtyped,
    }
allfus = sorted({h["func"] for h in allfunctions.values()})
with open(zigoutput, "w") as myfile:
    myfile.write(functionheader)
    for f in allfus:
        print(f)
        myfile.write(f + "\n")

print("functiondict={")
for k, v in allfunctions.items():
    print(f""""{k}":"{v["funcname"]}",""")

print("}")
