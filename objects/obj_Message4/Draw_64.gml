#region draw stuff

var xx = obj_Global.GUI_WIDTH * .5;
var yy = obj_Global.GUI_HEIGHT * .25;

var width = 444;

var container = ds_map_create();
container[? "str"] = "You can't carry any more shields.";
container[? "xx"] = xx;
container[? "yy"] = yy;
container[? "fillAlpha"] = .7;
container[? "textAlpha"] = 1;
container[? "width"] = width;
container[? "padding"] = 8;

draw_container(container);

#endregion