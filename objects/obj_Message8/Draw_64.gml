//
var data = ds_map_create();
data[? "xx"] = obj_Global.GUI_WIDTH * .5;
data[? "yy"] = obj_Global.GUI_HEIGHT * .5;
data[? "width"] = 360;
data[? "height"] = 260;
data[? "fillColor"] = c_ltgray;
data[? "fillAlpha"] = .5;
data[? "radius"] = 20;
data[? "grid"] = "column";

var middleChildList = ds_list_create();
ds_map_add_list(data, "children", middleChildList);

	var middleChild = ds_map_create();
	middleChild[? "margin"] = 20;
	middleChild[? "padding"] = 20;
	middleChild[? "fillColor"] = c_modern_black;
	middleChild[? "fillAlpha"] = .5;
	middleChild[? "flow"] = "split";
	middleChild[? "grid"] = "column";
	
	ds_list_add_map(middleChildList, middleChild);
	
	var cols = ds_list_create();
	ds_map_add_list(middleChild, "children", cols);
	
		var row1 = ds_map_create();
		row1[? "grid"] = "row";
		row1[? "flow"] = "split";
		row1[? "fillColor"] = c_green;
		row1[? "fillAlpha"] = .5;
		
		ds_list_add_map(cols, row1);
		
			var children1 = ds_list_create();
			ds_map_add_list(row1, "children", children1);
			
			var topLeft = ds_map_create();
			topLeft[? "margin"] = 10;
			topLeft[? "padding"] = 10;
			topLeft[? "fillColor"] = c_orange;
			topLeft[? "fillAlpha"] = .5;
			topLeft[? "hAlign"] = fa_left;
			topLeft[? "vAlign"] = fa_top;
			topLeft[? "str"] = "Top Left";
			
			ds_list_add_map(children1, topLeft);
			
			var topMiddle = ds_map_create();
			topMiddle[? "margin"] = 10;
			topMiddle[? "padding"] = 10;
			topMiddle[? "fillColor"] = c_orange;
			topMiddle[? "fillAlpha"] = .5;
			topMiddle[? "hAlign"] = fa_center;
			topMiddle[? "vAlign"] = fa_top;
			topMiddle[? "str"] = "Top Middle";
			
			ds_list_add_map(children1, topMiddle);
			
			var topRight = ds_map_create();
			topRight[? "margin"] = 10;
			topRight[? "padding"] = 10;
			topRight[? "fillColor"] = c_orange;
			topRight[? "fillAlpha"] = .5;
			topRight[? "hAlign"] = fa_right;
			topRight[? "vAlign"] = fa_top;
			topRight[? "str"] = "Top Right";
			
			ds_list_add_map(children1, topRight);
		
		var row2 = ds_map_create();
		row2[? "grid"] = "row";
		row2[? "flow"] = "split";
		row2[? "fillColor"] = c_blue;
		row2[? "fillAlpha"] = .5;
		
		ds_list_add_map(cols, row2);
		
			var children2 = ds_list_create();
			ds_map_add_list(row2, "children", children2);
			
			var middleLeft = ds_map_create();
			middleLeft[? "margin"] = 10;
			middleLeft[? "padding"] = 10;
			middleLeft[? "fillColor"] = c_purple;
			middleLeft[? "fillAlpha"] = .5;
			middleLeft[? "hAlign"] = fa_left;
			middleLeft[? "vAlign"] = fa_middle;
			middleLeft[? "str"] = "Middle Left";
			
			ds_list_add_map(children2, middleLeft);
			
			var middleMiddle = ds_map_create();
			middleMiddle[? "margin"] = 10;
			middleMiddle[? "padding"] = 10;
			middleMiddle[? "fillColor"] = c_purple;
			middleMiddle[? "fillAlpha"] = .5;
			middleMiddle[? "hAlign"] = fa_center;
			middleMiddle[? "vAlign"] = fa_middle;
			middleMiddle[? "str"] = "Middle Middle";
			
			ds_list_add_map(children2, middleMiddle);
			
			var middleRight = ds_map_create();
			middleRight[? "margin"] = 10;
			middleRight[? "padding"] = 10;
			middleRight[? "fillColor"] = c_purple;
			middleRight[? "fillAlpha"] = .5;
			middleRight[? "hAlign"] = fa_right;
			middleRight[? "vAlign"] = fa_middle;
			middleRight[? "str"] = "Middle Right";
			
			ds_list_add_map(children2, middleRight);
		
		var row3 = ds_map_create();
		row3[? "grid"] = "row";
		row3[? "flow"] = "split";
		row3[? "fillColor"] = c_red;
		row3[? "fillAlpha"] = .5;
		
		ds_list_add_map(cols, row3);
		
			var children3 = ds_list_create();
			ds_map_add_list(row3, "children", children3);
			
			var bottomLeft = ds_map_create();
			bottomLeft[? "margin"] = 10;
			bottomLeft[? "padding"] = 10;
			bottomLeft[? "fillColor"] = c_olive;
			bottomLeft[? "fillAlpha"] = .5;
			bottomLeft[? "hAlign"] = fa_left;
			bottomLeft[? "vAlign"] = fa_bottom;
			bottomLeft[? "str"] = "Bottom Left";
			
			ds_list_add_map(children3, bottomLeft);
			
			var bottomMiddle = ds_map_create();
			bottomMiddle[? "margin"] = 10;
			bottomMiddle[? "padding"] = 10;
			bottomMiddle[? "fillColor"] = c_olive;
			bottomMiddle[? "fillAlpha"] = .5;
			bottomMiddle[? "hAlign"] = fa_center;
			bottomMiddle[? "vAlign"] = fa_bottom;
			bottomMiddle[? "str"] = "Bottom Middle";
			
			ds_list_add_map(children3, bottomMiddle);
			
			var bottomRight = ds_map_create();
			bottomRight[? "margin"] = 10;
			bottomRight[? "padding"] = 10;
			bottomRight[? "fillColor"] = c_olive;
			bottomRight[? "fillAlpha"] = .5;
			bottomRight[? "hAlign"] = fa_right;
			bottomRight[? "vAlign"] = fa_bottom;
			bottomRight[? "str"] = "Bottom Right";
			
			ds_list_add_map(children3, bottomRight);
			

draw_container(data);
//