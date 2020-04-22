/// @description container_get_height_percent(data)
/// @param data

var data = argument0;

var parent = data[? "parent"];
if (parent == -1)
{
	return 1;	
}

var outside = data[? "marginTop"] + data[? "marginBottom"] + data[? "paddingTop"] + data[? "paddingBottom"];
return (outside + data[? "height"]) / parent[? "height"];