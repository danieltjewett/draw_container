/// @description container_get_width_percent(data)
/// @param data

var data = argument0;

var parent = data[? "parent"];
if (parent == -1)
{
	return 1;	
}

var outside = data[? "marginLeft"] + data[? "marginRight"] + data[? "paddingLeft"] + data[? "paddingRight"];
return (outside + data[? "width"]) / parent[? "width"];