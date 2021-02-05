#region draw stuff

var menuSize = array_length(menuList);
	
if (menuSize > 0)
{
	var startX = obj_Global.GUI_WIDTH * .5;
	var startY = obj_Global.GUI_HEIGHT * .5;
	
	var width = 100;
	var height = 25;
	
	var container = {
		x: startX,
		y: startY,
		width: width,
		grid: "column",
	};
	
	container.children = [];
	
	for (var i=0; i<menuSize; i++)
	{
		var menuItem = menuList[i];
		var str = menuItem.label;
		
		var menuItemContainer = {
			str: str,
			height: height,
			font: font_Arial8,
			fillAlpha: .7,
			textAlpha: 1,
			shadowAlpha: 1,
			flow: "split",
			grid: "row",
		};
		
		
		menuItemContainer.children = [];
		array_push(container.children, menuItemContainer);
		
		var button = -1;
		
		if (menuIndex == i)
		{
			menuItemContainer.fillColor = c_fuchsia;
			button = get_button_label_container("B", 0, .7, 1);
		}
		else if (i + 1 == menuSize)
		{
			button = get_button_label_container("A", 0, .7, 1);
		}
		
		if (button != -1)
		{
			button.hAnchor = fa_left;
			button.width = 1;
			
			array_push(menuItemContainer.children, button);
		}
	}

	draw_container(container);
}
	
#endregion