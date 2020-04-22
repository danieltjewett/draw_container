/// @description container_get_height(data)
/// @param data

var data = argument0;

return data[? "computedHeight"] - data[? "marginTop"] - data[? "marginBottom"] - data[? "paddingTop"] - data[? "paddingBottom"];