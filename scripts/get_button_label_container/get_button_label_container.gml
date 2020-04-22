/// @description get_button_label_container(label, imageIndex, spriteAlpha, textAlpha, [scale=1, col=-1, textColor=c_black, shadowColor=c_white])
/// @param label
/// @param imageIndex
/// @param spriteAlpha
/// @param textAlpha
/// @param [scale=1
/// @param col=-1
/// @param textColor=c_black
/// @param shadowColor=c_white]

var label = argument[0];
var imageIndex = argument[1];
var spriteAlpha = argument[2];
var textAlpha = argument[3];

var scale = 1;
var col = -1;
var textColor = c_black;
var shadowColor = c_white;

if (argument_count == 5)
{
	scale = argument[4];	
}
else if (argument_count == 6)
{
	scale = argument[4];
	col = argument[5];
}
else if (argument_count == 7)
{
	scale = argument[4];
	col = argument[5];
	textColor = argument[6];
}
else if (argument_count == 8)
{
	scale = argument[4];
	col = argument[5];
	textColor = argument[6];
	shadowColor = argument[7];
}

var buttonLabel = label;

var container = ds_map_create();
container[? "str"] = buttonLabel;
container[? "width"] = 18; //sprite_width
container[? "height"] = 18; //sprite_height
container[? "font"] = font_Calibri10;
container[? "fillAlpha"] = 0;
container[? "textAlpha"] = textAlpha;
container[? "textColor"] = textColor;
container[? "shadowColor"] = shadowColor;
container[? "sprite"] = sprite01;
container[? "imageIndex"] = imageIndex;
container[? "imageXscale"] = scale;
container[? "imageYscale"] = scale;
container[? "imageColor"] = col;
container[? "imageAlpha"] = spriteAlpha;

return container;