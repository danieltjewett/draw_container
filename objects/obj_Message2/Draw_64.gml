#region set positioning

var width = 280;

var xx = obj_Global.GUI_WIDTH * .5;
var yy = obj_Global.GUI_HEIGHT * .5;

#endregion
#region draw stuff

var container = ds_map_create();
container[? "xx"] = xx;
container[? "yy"] = yy;
container[? "width"] = width;
container[? "fillAlpha"] = .7;
container[? "radius"] = 5;
container[? "paddingLeft"] = 20;
container[? "paddingRight"] = 20;
container[? "paddingTop"] = 20;
container[? "grid"] = "column";

var columns = ds_list_create();
ds_map_add_list(container, "children", columns);

	var titleData = ds_map_create();
	titleData[? "str"] = "Open Inventory";
	titleData[? "textAlpha"] = 1;
	titleData[? "font"] = font_Arial12;
	titleData[? "marginBottom"] = 2;

	var descriptionData = ds_map_create();
	descriptionData[? "str"] = "Equip weapons, shields, and other gear here.";
	descriptionData[? "textAlpha"] = 1;
	descriptionData[? "font"] = font_Arial10;
	descriptionData[? "marginBottom"] = 10;
	
	ds_list_add_map(columns, titleData);
	ds_list_add_map(columns, descriptionData);

	var middleContainer = ds_map_create();
	middleContainer[? "flow"] = "split";
	
	ds_list_add_map(columns, middleContainer);
	
	var middleList = ds_list_create();
	ds_map_add_list(middleContainer, "children", middleList);

	var hasContent = false;
	var nextContainer = ds_map_create();
	nextContainer[? "marginTop"] = 5;
	nextContainer[? "flow"] = "split";
	
	var nextList = ds_list_create();
	ds_map_add_list(nextContainer, "children", nextList);
	
	//NOTE not adding nextContainer to columns yet until we know we have content

	//sprite
	var length = array_length_1d(sprites); //length of sprites and indexes should be the same

	for (var i=0; i<length; i++)
	{
		var sprite = sprites[i];
		var index = indexes[i];
		var label = labels[i];
	
		var middleData = ds_map_create();
		middleData[? "height"] = 112;
		middleData[? "sprite"] = sprite;
		middleData[? "imageXscale"] = .5;
		middleData[? "imageYscale"] = .5;
		middleData[? "imageIndex"] = index;
		middleData[? "imageAlpha"] = .7;
	
		var nextData = ds_map_create();
	
		if (!is_undefined(label))
		{
			hasContent = true;
			nextData[? "str"] = label;
			nextData[? "textAlpha"] = .7;
		}
	
		ds_list_add_map(middleList, middleData);
		ds_list_add_map(nextList, nextData);
	}
	
	if (hasContent)
	{
		ds_list_add_map(columns, nextContainer);	
	}
	else
	{
		ds_map_destroy(nextContainer); //removes the "children" too	
	}

var button = get_button_label_container("B", 0, .7, .7, 1, c_black, c_white, c_black);
button[? "vAnchor"] = fa_top;
ds_list_add_map(columns, button);
	
draw_container(container);

#endregion