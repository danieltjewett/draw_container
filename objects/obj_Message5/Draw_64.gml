#region draw stuff

var menuSize = ds_list_size(menuList);
	
if (menuSize > 0)
{
	var startX = obj_Global.GUI_WIDTH * .5;
	var startY = obj_Global.GUI_HEIGHT * .5;
	
	var width = 100;
	var height = 25;
	
	var container = ds_map_create();
	container[? "xx"] = startX;
	container[? "yy"] = startY;
	container[? "width"] = width;
	container[? "grid"] = "column";

	var children = ds_list_create();
	ds_map_add_list(container, "children", children);
	
	for (var i=0; i<menuSize; i++)
	{
		var menuItem = menuList[| i];
		var str = menuItem[? "label"];
		
		var menuItemContainer = ds_map_create();
		menuItemContainer[? "str"] = str;
		menuItemContainer[? "height"] = height;
		menuItemContainer[? "font"] = font_Arial8;
		menuItemContainer[? "fillAlpha"] = .7;
		menuItemContainer[? "textAlpha"] = 1;
		menuItemContainer[? "flow"] = "split";
		menuItemContainer[? "grid"] = "row";
		
		var nested = ds_list_create();
		ds_map_add_list(menuItemContainer, "children", nested);
		
		ds_list_add_map(children, menuItemContainer);
		
		var button = -1;
		
		if (menuIndex == i)
		{
			menuItemContainer[? "fillColor"] = c_fuchsia;
			button = get_button_label_container("B", 0, .7, 1);
		}
		else if (i + 1 == menuSize)
		{
			button = get_button_label_container("A", 0, .7, 1);
		}
		
		if (button != -1)
		{
			button[? "hAnchor"] = fa_left;
			button[? "width"] = 1;
			
			ds_list_add_map(nested, button);
		}
	}

	draw_container(container);
}
	
#endregion