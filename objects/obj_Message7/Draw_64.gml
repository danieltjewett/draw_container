#region draw stuff

var xx = obj_Global.GUI_WIDTH * .5;
var yy = obj_Global.GUI_HEIGHT - 100;

var text = currentMessage;
var index = floor(clamp(characterCounter, 0, currentMessageLength));
var printText = string_copy(text, 1, index);
	
var textBoxWidth = 500;
var textBoxHeight = 100;

//
var container = ds_map_create();
container[? "xx"] = xx;
container[? "yy"] = yy;
container[? "width"] = textBoxWidth;
container[? "grid"] = "column";

var children = ds_list_create();
ds_map_add_list(container, "children", children);

	var wrapper = ds_map_create();
	wrapper[? "height"] = textBoxHeight;
	wrapper[? "radius"] = -1;
	wrapper[? "fillAlpha"] = .7;
	
	ds_list_add_map(children, wrapper);
	
	var nest = ds_list_create();
	ds_map_add_list(wrapper, "children", nest);

		var portraitData = ds_map_create();
		portraitData[? "yy"] = -14;
		portraitData[? "width"] = 2;
		portraitData[? "sprite"] = messagePortrait;
		portraitData[? "imageAlpha"] = 1;
		
		ds_list_add_map(nest, portraitData);

		var messageContainer = ds_map_create();
		messageContainer[? "yy"] = -7;
		messageContainer[? "marginLeft"] = 50;
		
		ds_list_add_map(nest, messageContainer);

		var messageChildren = ds_list_create();
		ds_map_add_list(messageContainer, "children", messageChildren);
		
			var titleContainer = ds_map_create();
			var titleChildren = ds_list_create();
			ds_map_add_list(titleContainer, "children", titleChildren);

				var titleData = ds_map_create();
				titleData[? "str"] = messageTitle;
				titleData[? "textAlpha"] = 1;
				titleData[? "font"] = font_Arial10;
				titleData[? "hAlign"] = fa_left;
				titleData[? "sprite"] = spr_backdrop;
				titleData[? "spriteCover"] = true;
				titleData[? "imageAlpha"] = .7;

				var titleFiller = ds_map_create();

				ds_list_add_map(titleChildren, titleData);
				ds_list_add_map(titleChildren, titleFiller);

			ds_list_add_map(messageChildren, titleContainer);
		
			var messageData = ds_map_create();
			messageData[? "str"] = printText;
			messageData[? "yy"] = 8;
			messageData[? "paddingTop"] = 10;
			messageData[? "paddingRight"] = 20;
			messageData[? "paddingBottom"] = 8;
			messageData[? "textAlpha"] = 1;
			messageData[? "font"] = font_Arial12;
			messageData[? "hAlign"] = fa_left;
			messageData[? "vAlign"] = fa_top;
		
			ds_list_add_map(messageChildren, messageData);
	
	var sizeScale = 1;
	var spriteAlpha = 0;
	var textAlpha = 0;
	var textColor = c_white;
	var shadowColor = c_black;
	var color = c_black;
	if (characterCounter >= currentMessageLength)
	{
		spriteAlpha = .7;
		textAlpha = 1;
		if (messageIndex + 1 < messageLength)
		{
			textColor = c_black;
			shadowColor = c_white;
			color = -1;
		}
	}
	
	var button = get_button_label_container("B", 0, spriteAlpha, textAlpha, sizeScale, color, textColor, shadowColor);
	button[? "vAnchor"] = fa_bottom;
	ds_list_add_map(children, button);

draw_container(container);
//

characterCounter += characterCounterSpeed;

#endregion