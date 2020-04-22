//draw_textbox("Hi", [200, 200], false, -1, -1, -1, [0, 1], -1, 0);

//
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

var rows = ds_list_create();
ds_list_add_map(rows, col1);
ds_list_add_map(rows, col2);

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

ds_map_add_list(data, "children", rows);

draw_container(data);
//

//
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

var columns = ds_list_create();
ds_list_add_map(columns, col1);
ds_list_add_map(columns, col2);

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

ds_map_add_list(data, "children", columns);

draw_container(data);
//

//
var titleData = ds_map_create();
titleData[? "name"] = "titleData";
titleData[? "str"] = "Attack with Bow";
titleData[? "textAlpha"] = 1;
titleData[? "marginBottom"] = 2;

var descriptionData = ds_map_create();
descriptionData[? "name"] = "descriptionData";
descriptionData[? "str"] = "Equip a bow to attack enemies from afar like a turtle and rabbits.";
descriptionData[? "textAlpha"] = 1;
descriptionData[? "marginBottom"] = 10;

var columns = ds_list_create();
ds_list_add_map(columns, titleData);
ds_list_add_map(columns, descriptionData);

var middleContainer = ds_map_create();
middleContainer[? "name"] = "middleContainer";
middleContainer[? "flow"] = "split";

var nextContainer = ds_map_create();
nextContainer[? "marginTop"] = 10;
nextContainer[? "flow"] = "split";

var middleList = ds_list_create();
var nextList = ds_list_create();

//sprite
for (var i=0; i<2; i++)
{
	var sprite = sprite0;
	var index = 0;
	var label = "Draw bow";
	
	var middleData = ds_map_create();
	middleData[? "name"] = "middleData" + string(i);
	middleData[? "height"] = 84;
	middleData[? "sprite"] = sprite;
	middleData[? "imageIndex"] = index;
	middleData[? "imageXscale"] = .5;
	middleData[? "imageYscale"] = .5;
	middleData[? "spriteAlpha"] = 1;
	
	var nextData = ds_map_create();
	
	if (!is_undefined(label))
	{
		nextData[? "str"] = label;
		nextData[? "textAlpha"] = 1;
	}
	
	ds_list_add_map(middleList, middleData);
	ds_list_add_map(nextList, nextData);
}

ds_map_add_list(middleContainer, "children", middleList);
ds_map_add_list(nextContainer, "children", nextList);

ds_list_add_map(columns, middleContainer);
ds_list_add_map(columns, nextContainer);

var data = ds_map_create();
data[? "name"] = "data";
data[? "xx"] = GUI_WIDTH * .5;
data[? "yy"] = GUI_HEIGHT * .5;
data[? "width"] = 280;
//data[? "height"] = 170;
data[? "fillAlpha"] = .7;
data[? "radius"] = 5;
data[? "padding"] = 20;
data[? "grid"] = "column";

ds_map_add_list(data, "children", columns);

draw_container(data);
//

//
/***
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

var innerRows = ds_list_create();
ds_list_add_map(innerRows, title);
ds_list_add_map(innerRows, stat);
ds_list_add_map(innerRows, description);

var col2 = ds_map_create();
col2[? "width"] = .6;
col2[? "fillColor"] = c_yellow;
col2[? "fillAlpha"] = .5;
col2[? "marginLeft"] = 20;

ds_map_add_list(col2, "children", innerRows);

var col1 = ds_map_create();
col1[? "str"] = "PICTURE";
col1[? "width"] = .4;
col1[? "fillColor"] = c_yellow;
col1[? "fillAlpha"] = .5;

var rows = ds_list_create();
ds_list_add_map(rows, col1);
ds_list_add_map(rows, col2);

var data = ds_map_create();
data[? "xx"] = GUI_WIDTH * .5;
data[? "yy"] = GUI_HEIGHT * .5;
data[? "width"] = 260;
data[? "height"] = 160;
data[? "fillColor"] = c_modern_black;
data[? "fillAlpha"] = .8;
data[? "radius"] = 20;
data[? "padding"] = 20;
data[? "grid"] = "row";

ds_map_add_list(data, "children", rows);

draw_container(data);
***/
//

//
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

var columns = ds_list_create();
ds_list_add_map(columns, col1);
ds_list_add_map(columns, col2);

var data = ds_map_create();
data[? "name"] = "data";
data[? "xx"] = 550;
data[? "yy"] = 270;
data[? "width"] = 120;
data[? "height"] = 150;
data[? "fillAlpha"] = .8;
data[? "grid"] = "column";

ds_map_add_list(data, "children", columns);

draw_container(data);
//

//
var data = ds_map_create();
data[? "str"] = "SHIELD";
data[? "xx"] = 320;
data[? "yy"] = GUI_HEIGHT;
data[? "vAnchor"] = fa_bottom;
data[? "width"] = 50;
data[? "height"] = 20;
data[? "font"] = font_Arial8;
data[? "fillAlpha"] = .8;

draw_container(data);
//

//
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

var columns = ds_list_create();
ds_list_add_map(columns, col1);
ds_list_add_map(columns, col2);

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
ds_map_add_list(data, "children", columns);

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
data[? "sprite"] = sprite0;

draw_container(data);
//

//
var data = ds_map_create();
data[? "str"] = "Sword";
data[? "hAnchor"] = fa_right;
data[? "xx"] = GUI_WIDTH;
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
data[? "sprite"] = sprite1;
data[? "spriteCover"] = true;

draw_container(data);



/*
var pausePageSize = 10;
var pausePage = 9;

var _image_alpha = 1;
var alphaMulti = .8;

var arr = [];
arr[0] = "Balanced Weapons";
arr[1] = "Agile Weapons";
arr[2] = "Heavy Weapons";
arr[3] = "Fire Rods";
arr[4] = "Ice Rods";
arr[5] = "Water Rods";
arr[6] = "Shields";
arr[7] = "Bows";
arr[8] = "Materials";
arr[9] = "Options";

var menuIconsChildren = ds_list_create();

var leftButton = get_button_label_container("L", 1, 0, 0, _image_alpha * alphaMulti, _image_alpha);
leftButton[? "marginRight"] = -5;
ds_list_add_map(menuIconsChildren, leftButton);
	
for (var i=0; i<pausePageSize; i++)
{
	var icon = ds_map_create();
	
	var alpha = .25 * _image_alpha;
	
	if (pausePage == i)
	{
		alpha = 1 * _image_alpha;
		
		var iconLabel = ds_map_create();
		iconLabel[? "yy"] = -20;
		iconLabel[? "str"] = arr[i];
		iconLabel[? "textAlpha"] = _image_alpha;
		
		var iconLabelList = ds_list_create();
		ds_list_add_map(iconLabelList, iconLabel);
		
		ds_map_add_list(icon, "children", iconLabelList);
	}
	
	icon[? "width"] = 24;
	icon[? "height"] = 24;
	icon[? "sprite"] = sprite01;
	icon[? "imageIndex"] = i;
	icon[? "imageAlpha"] = alpha;
	icon[? "marginLeft"] = 10;
	icon[? "marginRight"] = 10;
	icon[? "fillColor"] = c_yellow;
	icon[? "fillAlpha"] = .5;
	
	ds_list_add_map(menuIconsChildren, icon);
}

var rightButton = get_button_label_container("R", 2, 0, 0, _image_alpha * alphaMulti, _image_alpha);
rightButton[? "marginLeft"] = -5;
ds_list_add_map(menuIconsChildren, rightButton);

var menuIcons = ds_map_create();
menuIcons[? "hAnchor"] = fa_left;
menuIcons[? "xx"] = 20;
menuIcons[? "yy"] = 70;
menuIcons[? "grid"] = "row";
menuIcons[? "fillColor"] = c_blue;
menuIcons[? "fillAlpha"] = .5;

ds_map_add_list(menuIcons, "children", menuIconsChildren);

draw_container(menuIcons);
*/

if (state == 2)
{
	var x1 = px1 * GUI_WIDTH;
	var y1 = py1 * GUI_HEIGHT;
	
	var x2 = px2 * GUI_WIDTH;
	var y2 = py2 * GUI_HEIGHT;
	
	draw_line_color(x1, y1, x2, y2, c_silver, c_red);
	draw_text(x1, y1, string(point_distance(x1, y1, x2, y2)));
}