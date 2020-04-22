#region set positioning

var halfScreenWidth = obj_Global.GUI_WIDTH * .5;
var halfScreenHeight = obj_Global.GUI_HEIGHT * .5;

var bottomScreenHeight = obj_Global.GUI_HEIGHT * .9;

var xx = halfScreenWidth;
var yy = halfScreenHeight;

#endregion
#region draw stuff

var str = "Game Over";

var str1 = "Press Start to Continue";

var str2 = "Battle Tip:  Taking on enemies that are too tough is a good sign that it is too soon to explore an area.";

var container = ds_map_create();
container[? "xx"] = xx;
container[? "yy"] = yy;
container[? "width"] = obj_Global.GUI_WIDTH;
container[? "height"] = obj_Global.GUI_HEIGHT;
container[? "fillAlpha"] = 1;
container[? "flow"] = "split";
container[? "grid"] = "column";

var children = ds_list_create();
ds_map_add_list(container, "children", children);

	var topData = ds_map_create();
	topData[? "height"] = .45;
	
	ds_list_add_map(children, topData);

	var gameOverData = ds_map_create();
	gameOverData[? "str"] = str;
	gameOverData[? "height"] = .1;
	gameOverData[? "font"] = font_Arial16;
	gameOverData[? "textColor"] = c_red;
	gameOverData[? "textAlpha"] = 1;
	
	ds_list_add_map(children, gameOverData);

	var startData = ds_map_create();
	startData[? "str"] = str1;
	startData[? "height"] = .2;
	startData[? "font"] = font_Arial10;
	startData[? "textAlpha"] = 1;
	
	ds_list_add_map(children, startData);

	var gap = ds_map_create();
	gap[? "height"] = .05;
	
	ds_list_add_map(children, gap);

	var tipData = ds_map_create();
	tipData[? "str"] = str2;
	tipData[? "width"] = .65;
	tipData[? "height"] = .2;
	tipData[? "font"] = font_Arial10;
	tipData[? "textAlpha"] = 1;
	
	ds_list_add_map(children, tipData);

draw_container(container);

#endregion