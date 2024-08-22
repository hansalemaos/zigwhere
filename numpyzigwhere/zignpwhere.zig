const std = @import("std");
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

export fn np_zig_where_c_char(array_address: usize, search_for: usize, array_len: usize, callback_fu: usize, result_vector: usize, operation: usize, address_np_shape: usize, np_shape_len: usize) ?*void {
    const thisdtype = [*]c_char;
    const thisdtype_no_pointer = c_char;
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

export fn np_zig_where_c_int(array_address: usize, search_for: usize, array_len: usize, callback_fu: usize, result_vector: usize, operation: usize, address_np_shape: usize, np_shape_len: usize) ?*void {
    const thisdtype = [*]c_int;
    const thisdtype_no_pointer = c_int;
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

export fn np_zig_where_c_longlong(array_address: usize, search_for: usize, array_len: usize, callback_fu: usize, result_vector: usize, operation: usize, address_np_shape: usize, np_shape_len: usize) ?*void {
    const thisdtype = [*]c_longlong;
    const thisdtype_no_pointer = c_longlong;
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

export fn np_zig_where_c_short(array_address: usize, search_for: usize, array_len: usize, callback_fu: usize, result_vector: usize, operation: usize, address_np_shape: usize, np_shape_len: usize) ?*void {
    const thisdtype = [*]c_short;
    const thisdtype_no_pointer = c_short;
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

export fn np_zig_where_c_uint(array_address: usize, search_for: usize, array_len: usize, callback_fu: usize, result_vector: usize, operation: usize, address_np_shape: usize, np_shape_len: usize) ?*void {
    const thisdtype = [*]c_uint;
    const thisdtype_no_pointer = c_uint;
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

export fn np_zig_where_c_ulonglong(array_address: usize, search_for: usize, array_len: usize, callback_fu: usize, result_vector: usize, operation: usize, address_np_shape: usize, np_shape_len: usize) ?*void {
    const thisdtype = [*]c_ulonglong;
    const thisdtype_no_pointer = c_ulonglong;
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

export fn np_zig_where_c_ushort(array_address: usize, search_for: usize, array_len: usize, callback_fu: usize, result_vector: usize, operation: usize, address_np_shape: usize, np_shape_len: usize) ?*void {
    const thisdtype = [*]c_ushort;
    const thisdtype_no_pointer = c_ushort;
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

export fn np_zig_where_f128(array_address: usize, search_for: usize, array_len: usize, callback_fu: usize, result_vector: usize, operation: usize, address_np_shape: usize, np_shape_len: usize) ?*void {
    const thisdtype = [*]f128;
    const thisdtype_no_pointer = f128;
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

export fn np_zig_where_f32(array_address: usize, search_for: usize, array_len: usize, callback_fu: usize, result_vector: usize, operation: usize, address_np_shape: usize, np_shape_len: usize) ?*void {
    const thisdtype = [*]f32;
    const thisdtype_no_pointer = f32;
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

export fn np_zig_where_f64(array_address: usize, search_for: usize, array_len: usize, callback_fu: usize, result_vector: usize, operation: usize, address_np_shape: usize, np_shape_len: usize) ?*void {
    const thisdtype = [*]f64;
    const thisdtype_no_pointer = f64;
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

export fn np_zig_where_u8(array_address: usize, search_for: usize, array_len: usize, callback_fu: usize, result_vector: usize, operation: usize, address_np_shape: usize, np_shape_len: usize) ?*void {
    const thisdtype = [*]u8;
    const thisdtype_no_pointer = u8;
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
