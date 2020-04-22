/// @description ds_list_add_map(list, map)
/// @param list
/// @param map

var list = argument0;
var map = argument1;

ds_list_add(list, map);

var index = ds_list_size(list) - 1;

ds_list_mark_as_map(list, index);