#region draw stuff

var startX = obj_Global.GUI_WIDTH * .5;
var startY = obj_Global.GUI_HEIGHT * .5;

var width = 100;
var height = 25;

var color = c_fuchsia;
var str = string(40);

var container = ds_map_create();
container[? "str"] = str;
container[? "xx"] = startX;
container[? "yy"] = startY;
container[? "width"] = width;
container[? "height"] = height;
container[? "font"] = font_Arial8;
container[? "fillAlpha"] = .7;
container[? "fillColor"] = color;
container[? "textAlpha"] = 1;
container[? "flow"] = "split";
container[? "grid"] = "row";

var children = ds_list_create();
ds_map_add_list(container, "children", children);

	var sprite1 = ds_map_create();
	sprite1[? "sprite"] = spr_arrow;
	sprite1[? "imageIndex"] = 2;
	sprite1[? "image_alpha"] = .7;
	sprite1[? "hAnchor"] = fa_right;

	var sprite2 = ds_map_create();
	sprite2[? "sprite"] = spr_arrow;
	sprite2[? "imageIndex"] = 0;
	sprite2[? "image_alpha"] = .7;
	sprite2[? "hAnchor"] = fa_left;

	ds_list_add_map(children, sprite1);
	ds_list_add_map(children, sprite2);

draw_container(container);

#endregion