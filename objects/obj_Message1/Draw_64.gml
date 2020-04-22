#region draw stuff

var width = 130;

var xx = obj_Global.GUI_WIDTH;
var yy = 60;

var container = ds_map_create();
container[? "str"] = "This is an example of a message that could be used for a tip.";
container[? "xx"] = xx;
container[? "yy"] = yy;
container[? "hAnchor"] = fa_right;
container[? "vAnchor"] = fa_top;
container[? "font"] = font_Arial8;
container[? "hAlign"] = fa_left;
container[? "fillAlpha"] = .7;
container[? "textAlpha"] = 1;
container[? "width"] = width;
container[? "paddingTop"] = 10;
container[? "paddingBottom"] = 10;
container[? "paddingLeft"] = 15;
container[? "paddingRight"] = 15;

draw_container(container);

#endregion