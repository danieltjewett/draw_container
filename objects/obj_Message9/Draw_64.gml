//
var data = ds_map_create();
data[? "xx"] = 550;
data[? "yy"] = 50;
data[? "width"] = 100;
data[? "height"] = 50;
data[? "fillColor"] = c_modern_black;
data[? "fillAlpha"] = .8;
//data[? "padding"] = 20;
data[? "grid"] = "row";
data[? "flow"] = "split";

var rows = ds_list_create();
ds_map_add_list(data, "children", rows);

	var col1 = ds_map_create();
	col1[? "str"] = "PIC";
	col1[? "fillAlpha"] = .5;
	col1[? "fillColor"] = c_red;
	col1[? "paddingLeft"] = 20;
	col1[? "paddingTop"] = 10;
	col1[? "paddingRight"] = 10;
	col1[? "paddingBottom"] = 10;
	col1[? "hAlign"] = fa_left;
	col1[? "vAlign"] = fa_bottom;

	var col2 = ds_map_create();
	col2[? "str"] = "Kar";
	col2[? "fillAlpha"] = .5;
	col2[? "fillColor"] = c_green;
	col2[? "marginLeft"] = 10;
	col2[? "marginTop"] = 10;
	col2[? "marginRight"] = 10;
	col2[? "marginBottom"] = 10;
	col2[? "hAlign"] = fa_left;
	col2[? "vAlign"] = fa_top;
	
	ds_list_add_map(rows, col1);
	ds_list_add_map(rows, col2);

draw_container(data);
//

//
var data = ds_map_create();
data[? "xx"] = 0;
data[? "yy"] = 270;
data[? "hAnchor"] = fa_left;
data[? "width"] = 100;
data[? "height"] = 100;
data[? "fillColor"] = c_modern_black;
data[? "fillAlpha"] = .8;
data[? "radius"] = 20;
data[? "padding"] = 10;
data[? "grid"] = "column";
data[? "flow"] = "split";

var columns = ds_list_create();
ds_map_add_list(data, "children", columns);

	var col1 = ds_map_create();
	col1[? "str"] = "PICTURE";
	col1[? "fillAlpha"] = .5;
	col1[? "fillColor"] = c_red;
	col1[? "paddingRight"] = 10;
	col1[? "paddingBottom"] = 10;
	col1[? "hAlign"] = fa_right;
	col1[? "vAlign"] = fa_bottom;

	var col2 = ds_map_create();
	col2[? "str"] = "Karen";
	col2[? "fillAlpha"] = .5;
	col2[? "fillColor"] = c_green;
	col2[? "marginRight"] = 10;
	col2[? "marginTop"] = 10;
	col2[? "hAlign"] = fa_center;
	col2[? "vAlign"] = fa_bottom;

	ds_list_add_map(columns, col1);
	ds_list_add_map(columns, col2);

draw_container(data);
//

//
var data = ds_map_create();
data[? "name"] = "data";
data[? "xx"] = 550;
data[? "yy"] = 270;
data[? "width"] = 120;
data[? "height"] = 150;
data[? "fillAlpha"] = .8;
data[? "grid"] = "column";

var columns = ds_list_create();
ds_map_add_list(data, "children", columns);

	var col1 = ds_map_create();
	col1[? "name"] = "col1";
	col1[? "str"] = "I am getting so sick of this not working.  My neck is sore and I should go to bed, since I have to work tomorrow.";
	col1[? "fillAlpha"] = .5;
	col1[? "fillColor"] = c_red;
	col1[? "padding"] = 10;
	col1[? "marginBottom"] = 10;
	col1[? "hAlign"] = fa_right;
	col1[? "vAlign"] = fa_bottom;

	var col2 = ds_map_create();
	col2[? "name"] = "col2";
	col2[? "str"] = "Bunny";
	col2[? "fillAlpha"] = .5;
	col2[? "fillColor"] = c_green;
	col2[? "padding"] = 10;
	col2[? "marginTop"] = 10;
	col2[? "hAlign"] = fa_center;
	col2[? "vAlign"] = fa_top;

	ds_list_add_map(columns, col1);
	ds_list_add_map(columns, col2);

draw_container(data);
//

//
var data = ds_map_create();
data[? "str"] = "SHIELD";
data[? "xx"] = 320;
data[? "yy"] = obj_Global.GUI_HEIGHT;
data[? "vAnchor"] = fa_bottom;
data[? "width"] = 50;
data[? "height"] = 20;
data[? "font"] = font_Arial8;
data[? "fillAlpha"] = .8;

draw_container(data);
//

//
var data = ds_map_create();
data[? "xx"] = 300;
data[? "yy"] = 0;
data[? "vAnchor"] = fa_top;
data[? "width"] = 350;
data[? "height"] = 50;
data[? "font"] = font_Arial8;
data[? "fillAlpha"] = .8;
data[? "flow"] = "fill";
data[? "grid"] = "row";

var columns = ds_list_create();
ds_map_add_list(data, "children", columns);

	var col1 = ds_map_create();
	col1[? "str"] = "This is so much fun!  I just love it when it works correctly.";
	col1[? "fillAlpha"] = .5;
	col1[? "fillColor"] = c_red;
	col1[? "paddingRight"] = 10;
	col1[? "marginLeft"] = 10;
	col1[? "hAlign"] = fa_right;
	col1[? "vAlign"] = fa_bottom;

	var col2 = ds_map_create();
	col2[? "str"] = "Done";
	col2[? "fillAlpha"] = .5;
	col2[? "fillColor"] = c_green;
	col2[? "paddingLeft"] = 10;
	col2[? "marginLeft"] = 10;
	col2[? "hAlign"] = fa_center;
	col2[? "vAlign"] = fa_top;

	ds_list_add_map(columns, col1);
	ds_list_add_map(columns, col2);

draw_container(data);
//

//
var data = ds_map_create();
data[? "str"] = "Target";
data[? "xx"] = 80;
data[? "yy"] = 130;
data[? "width"] = 90;
data[? "height"] = 90;
data[? "font"] = font_Arial8;
data[? "fillAlpha"] = .8;
data[? "hAlign"] = fa_right;
data[? "vAlign"] = fa_top;
data[? "sprite"] = spr_backdrop;

draw_container(data);
//

//
var data = ds_map_create();
data[? "str"] = "Sword";
data[? "hAnchor"] = fa_right;
data[? "xx"] = obj_Global.GUI_WIDTH;
data[? "yy"] = 140;
data[? "width"] = 50;
data[? "height"] = 50;
data[? "font"] = font_Arial8;
data[? "fillAlpha"] = .8;
data[? "radius"] = -1;
data[? "hAlign"] = fa_left;
data[? "vAlign"] = fa_middle;
data[? "padding"] = 20;

draw_container(data);
//

//
var data = ds_map_create();
data[? "str"] = "Michigan";
data[? "xx"] = 40;
data[? "yy"] = 20;
data[? "textColor"] = c_black;
data[? "shadowAlpha"] = .1;
data[? "shadowColor"] = c_white;

draw_container(data);
//

//
var data = ds_map_create();
data[? "str"] = "Michigan";
data[? "xx"] = 40;
data[? "yy"] = 60;
data[? "sprite"] = spr_backdrop;
data[? "spriteCover"] = true;

draw_container(data);
//

//
var data = ds_map_create();
data[? "xx"] = obj_Global.GUI_WIDTH * .5;
data[? "yy"] = obj_Global.GUI_HEIGHT * .5;
data[? "width"] = 260;
data[? "height"] = 160;
data[? "fillColor"] = c_modern_black;
data[? "fillAlpha"] = .8;
data[? "radius"] = 20;
data[? "padding"] = 20;
data[? "grid"] = "row";

var rows = ds_list_create();
ds_map_add_list(data, "children", rows);

	var col1 = ds_map_create();
	col1[? "str"] = "PICTURE";
	col1[? "width"] = .4;
	col1[? "fillColor"] = c_yellow;
	col1[? "fillAlpha"] = .5;
	
	ds_list_add_map(rows, col1);
	
	var col2 = ds_map_create();
	col2[? "width"] = .6;
	col2[? "fillColor"] = c_yellow;
	col2[? "fillAlpha"] = .5;
	col2[? "marginLeft"] = 20;
	
	ds_list_add_map(rows, col2);
	
	var innerRows = ds_list_create();
	ds_map_add_list(col2, "children", innerRows);
	
		var title = ds_map_create();
		title[? "str"] = "Sword";
		title[? "hAlign"] = fa_center;
		title[? "fillColor"] = c_red;
		title[? "fillAlpha"] = .5;
		title[? "height"] = .15;

		var stat = ds_map_create();
		stat[? "str"] = "20";
		stat[? "hAlign"] = fa_right;
		stat[? "vAlign"] = fa_top;
		stat[? "fillColor"] = c_green;
		stat[? "fillAlpha"] = .5;
		stat[? "height"] = .15;

		var description = ds_map_create();
		description[? "str"] = "This is a description of a sword that is really cute and yummy.";
		description[? "hAlign"] = fa_left;
		description[? "vAlign"] = fa_top;
		description[? "fillColor"] = c_blue;
		description[? "fillAlpha"] = .5;
		description[? "height"] = .7;
		description[? "marginTop"] = 10;
		
		ds_list_add_map(innerRows, title);
		ds_list_add_map(innerRows, stat);
		ds_list_add_map(innerRows, description);

draw_container(data);
//