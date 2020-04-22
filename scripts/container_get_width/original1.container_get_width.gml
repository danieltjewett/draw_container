/// @description container_get_width(data)
/// @param data

var data = argument0;

return data[? "computedWidth"] - data[? "marginLeft"] - data[? "marginRight"] - data[? "paddingLeft"] - data[? "paddingRight"];