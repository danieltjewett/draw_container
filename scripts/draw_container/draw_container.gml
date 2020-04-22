/// @description draw_container(data, [calculateOnly=false])
/// @param data
/// @param [calculateOnly=false]

var data = argument[0];
var calculateOnly = false;

if (argument_count == 2)
{
	calculateOnly = argument[1];
}

var prevAlpha = draw_get_alpha();
var prevColor = draw_get_color();

var hasParent = false;
var parent = -1;

var parentChildren = -1;
var parentChildrenSize = 0;

if (ds_map_exists(data, "parent"))
{
	hasParent = true;
	parent = data[? "parent"];
	
	parentChildren = parent[? "children"];
	parentChildrenSize = ds_list_size(parentChildren);
}
else
{
	data[? "parent"] = -1;
}

#region margin

if (ds_map_exists(data, "margin"))
{
	if (!hasParent)
	{
		show_error("margin doesn't really do anything to root", true);
	}
	else
	{
		data[? "marginLeft"] = data[? "margin"];
		data[? "marginTop"] = data[? "margin"];
		data[? "marginRight"] = data[? "margin"];
		data[? "marginBottom"] = data[? "margin"];
	}
}
else
{
	if (!ds_map_exists(data, "marginLeft"))
	{
		data[? "marginLeft"] = 0;
	}
	else if (!hasParent)
	{
		show_error("marginLeft doesn't really do anything to root", true);
	}
	
	if (!ds_map_exists(data, "marginTop"))
	{
		data[? "marginTop"] = 0;
	}
	else if (!hasParent)
	{
		show_error("marginTop doesn't really do anything to root", true);
	}
	
	if (!ds_map_exists(data, "marginRight"))
	{
		data[? "marginRight"] = 0;
	}
	else if (!hasParent)
	{
		show_error("marginRight doesn't really do anything to root", true);
	}
	
	if (!ds_map_exists(data, "marginBottom"))
	{
		data[? "marginBottom"] = 0;
	}
	else if (!hasParent)
	{
		show_error("marginBottom doesn't really do anything to root", true);
	}
}

#endregion
#region padding

if (ds_map_exists(data, "padding"))
{
	data[? "paddingLeft"] = data[? "padding"];
	data[? "paddingTop"] = data[? "padding"];
	data[? "paddingRight"] = data[? "padding"];
	data[? "paddingBottom"] = data[? "padding"];
}
else
{
	if (!ds_map_exists(data, "paddingLeft"))
	{
		data[? "paddingLeft"] = 0;
	}
	if (!ds_map_exists(data, "paddingTop"))
	{
		data[? "paddingTop"] = 0;
	}
	if (!ds_map_exists(data, "paddingRight"))
	{
		data[? "paddingRight"] = 0;
	}
	if (!ds_map_exists(data, "paddingBottom"))
	{
		data[? "paddingBottom"] = 0;
	}
}

#endregion
#region compute children

var hasChildren = false;
var children = -1;
var childrenSize = 0;

if (ds_map_exists(data, "children"))
{
	children = data[? "children"];
	childrenSize = ds_list_size(children);
	
	hasChildren = childrenSize > 0;
}

if (hasChildren)
{
	if (!hasParent)
	{
		if (!ds_map_exists(data, "grid"))
		{
			show_error("Root with children needs to specify a grid type", true);
		}
	}
	else
	{
		if (!ds_map_exists(data, "grid"))
		{
			if (parent[? "grid"] == "column")
			{
				data[? "grid"] = "row";
			}	
			else if (parent[? "grid"] == "row")
			{
				data[? "grid"] = "column";
			}
		}
	}
	
	//prevents recalculating children (thus throwing grid error)
	if (!ds_map_exists(data, "_calculated") || !data[? "_calculated"])
	{
		for (var i=0; i<childrenSize; i++)
		{
			var child = children[| i];
			child[? "parent"] = data;
		
			draw_container(child, true);
		}
	}
}

#endregion
#region str

if (!ds_map_exists(data, "str"))
{
	data[? "str"] = "";
}

#endregion
#region font

if (!ds_map_exists(data, "font"))
{
	data[? "font"] = font_Arial8;
}

draw_set_font(data[? "font"]);

#endregion
#region line height

if (!ds_map_exists(data, "lineHeight"))
{
	data[? "lineHeight"] = -1;
}

#endregion
#region strWidth

if (!ds_map_exists(data, "strWidth"))
{
	data[? "strWidth"] = string_width(data[? "str"]);
}

#endregion
#region strHeight

if (!ds_map_exists(data, "strHeight"))
{
	var width = 0;
	var widthPercent = 1;
	
	var current = data;
	
	//walk up the parent to find a width to base computed height around
	while (current != -1 && width == 0)
	{
		if (ds_map_exists(current, "width"))
		{
			width = current[? "width"];
			
			if (width <= 1)
			{
				widthPercent *= width;
				width = 0;
			}
			else if (width > 1)
			{
				width *= widthPercent;
			}
		}
		
		current = current[? "parent"];
	}
	
	//if we find nothing, just use it's current width
	if (width == 0)
	{
		width = data[? "strWidth"];	
	}
	else if (hasParent) //take into account current margin width and padding width, if it is not the root
	{
		width -= data[? "marginLeft"] + data[? "marginLeft"] + data[? "paddingLeft"] + data[? "paddingRight"];
	}
	
	data[? "strHeight"] = string_height_ext(data[? "str"], data[? "lineHeight"], width);
}

#endregion
#region flow

if (!ds_map_exists(data, "flow"))
{
	data[? "flow"] = "fill";
}

#endregion
#region computed width

if (!ds_map_exists(data, "computedWidth"))
{
	var width;
	
	//integer width override content
	if (ds_map_exists(data, "width") && data[? "width"] > 1)
	{
		width = data[? "width"];
	}
	else if (hasChildren)
	{
		width = 0;
	
		for (var i=0; i<childrenSize; i++)
		{
			var child = children[| i];
			
			if (data[? "grid"] == "column")
			{
				width = max(width, child[? "computedWidth"]);
			}
			else
			{
				width += child[? "computedWidth"];
			}
		}
	}
	else
	{
		width = data[? "strWidth"];	
	}
	
	width += data[? "marginLeft"] + data[? "marginRight"] + data[? "paddingLeft"] + data[? "paddingRight"];
	
	data[? "computedWidth"] = width;
}

#endregion
#region computed height

if (!ds_map_exists(data, "computedHeight"))
{	
	var height;
	
	//integer heights override content
	if (ds_map_exists(data, "height") && data[? "height"] > 1)
	{
		height = data[? "height"];
	}
	else if (hasChildren)
	{
		height = 0;
	
		for (var i=0; i<childrenSize; i++)
		{
			var child = children[| i];
			
			if (data[? "grid"] == "row")
			{
				height = max(height, child[? "computedHeight"]);
			}
			else
			{
				height += child[? "computedHeight"];
			}
		}
	}
	else
	{
		height = data[? "strHeight"];	
	}
	
	height += data[? "marginTop"] + data[? "marginBottom"] + data[? "paddingTop"] + data[? "paddingBottom"];
	
	data[? "computedHeight"] = height;
}

#endregion
#region end prematurely, if necessary

if (calculateOnly)
{
	data[? "_calculated"] = true;
	return;
}

draw_set_font(data[? "font"]);

#endregion
#region horizontal anchor

if (!ds_map_exists(data, "hAnchor"))
{
	data[? "hAnchor"] = fa_center;
}

#endregion
#region vertical anchor

if (!ds_map_exists(data, "vAnchor"))
{
	data[? "vAnchor"] = fa_middle;
}

#endregion
#region sprite

var spriteWidth = 0;
var spriteHeight = 0;

if (!ds_map_exists(data, "sprite"))
{
	data[? "sprite"] = "";
}
else
{
	spriteWidth = sprite_get_width(data[? "sprite"]);
	spriteHeight = sprite_get_height(data[? "sprite"]);
}

#endregion
#region image index

if (!ds_map_exists(data, "imageIndex"))
{
	data[? "imageIndex"] = 0;
}

#endregion
#region image rotation

if (!ds_map_exists(data, "imageRotation"))
{
	data[? "imageRotation"] = 0;
}

#endregion
#region image color

if (!ds_map_exists(data, "imageColor"))
{
	data[? "imageColor"] = -1;
}

#endregion
#region image alpha

if (!ds_map_exists(data, "imageAlpha"))
{
	data[? "imageAlpha"] = 1;
}

#endregion
#region width

if (!ds_map_exists(data, "width"))
{
	if (!hasParent)
	{
		if (data[? "flow"] == "fill")
		{
			data[? "width"] = container_get_width(data);
			data[? "widthPercent"] = container_get_width_percent(data);
		}
		else if (data[? "flow"] == "split")
		{
			data[? "width"] = data[? "strWidth"];
			data[? "widthPercent"] = 1;
		}
		else
		{
			show_error("Unknown flow property, " + data[? "flow"], true);
		}
	}
	else
	{
		if (parent[? "flow"] == "fill")
		{
			if (parent[? "grid"] == "row")
			{
				//if we are on the last child, sum up current percentages and 1 - the percent is the remainder
				if (parentChildren[| parentChildrenSize - 1] == data)
				{
					var percent = 0;
					for (var i=0; i<parentChildrenSize - 1; i++)
					{
						var child = parentChildren[| i];
						percent += child[? "widthPercent"];
					}
				
					data[? "width"] = 1 - percent;
				}
				else
				{
					data[? "width"] = container_get_width(data);
					data[? "widthPercent"] = container_get_width_percent(data);
				}
			}
			else
			{
				data[? "width"] = 1;
			}
		}
		else if (parent[? "flow"] == "split")
		{
			if (parent[? "grid"] == "row")
			{
				data[? "width"] = 1 / parentChildrenSize;
			}
			else
			{
				data[? "width"] = 1;
			}
		}
		else
		{
			show_error("Unknown flow property, " + parent[? "flow"], true);
		}
	}
}
else if (data[? "width"] > 1)
{
	if (hasParent)
	{
		data[? "widthPercent"] = container_get_width_percent(data); //data[? "width"] / parent[? "width"];
	}
	else
	{
		data[? "widthPercent"] = 1;
	}
}

if (data[? "width"] <= 1) //percentage
{
	data[? "widthPercent"] = data[? "width"];
	data[? "width"] = (parent[? "width"] * data[? "width"]) - data[? "marginLeft"] - data[? "marginRight"] - data[? "paddingLeft"] - data[? "paddingRight"];
}

#endregion
#region height

if (!ds_map_exists(data, "height"))
{
	if (!hasParent)
	{
		if (data[? "flow"] == "fill")
		{
			data[? "height"] = container_get_height(data);
			data[? "heightPercent"] = container_get_height_percent(data);
		}
		else if (data[? "flow"] == "split")
		{
			data[? "height"] = data[? "strHeight"];
			data[? "heightPercent"] = 1;
		}
		else
		{
			show_error("Unknown flow property, " + data[? "flow"], true);
		}
	}
	else
	{
		if (parent[? "flow"] == "fill")
		{
			if (parent[? "grid"] == "column")
			{
				//if we are on the last child, sum up current percentages and 1 - the percent is the remainder
				if (parentChildren[| parentChildrenSize - 1] == data)
				{
					var percent = 0;
					for (var i=0; i<parentChildrenSize - 1; i++)
					{
						var child = parentChildren[| i];
						percent += child[? "heightPercent"];
					}
				
					data[? "height"] = 1 - percent;
				}
				else
				{
					data[? "height"] = container_get_height(data);
					data[? "heightPercent"] = container_get_height_percent(data);
				}
			}
			else
			{
				data[? "height"] = 1;
			}
		}
		else if (parent[? "flow"] == "split")
		{
			if (parent[? "grid"] == "column")
			{
				data[? "height"] = 1 / parentChildrenSize;
			}
			else
			{
				data[? "height"] = 1;
			}
		}
		else
		{
			show_error("Unknown flow property, " + parent[? "flow"], true);
		}
	}
}
else if (data[? "height"] > 1)
{
	if (hasParent)
	{
		data[? "heightPercent"] = container_get_height_percent(data); //data[? "height"] / parent[? "height"];
	}
	else
	{
		data[? "heightPercent"] = 1;
	}
}

if (data[? "height"] <= 1) //percentage
{
	data[? "heightPercent"] = data[? "height"];
	data[? "height"] = (parent[? "height"] * data[? "height"]) - data[? "marginTop"] - data[? "marginBottom"] - data[? "paddingTop"] - data[? "paddingBottom"];
}

#endregion
#region xx

if (!ds_map_exists(data, "xx"))
{
	data[? "xx"] = 0;
}

//TODO -1
switch (data[? "hAnchor"])
{
	case fa_left:
		data[? "xx"] += (data[? "width"] + data[? "paddingLeft"] + data[? "paddingRight"]) * .5 - 1;
		break;
		
	case fa_center:
		data[? "xx"] += 0;
		break;
		
	case fa_right:
		data[? "xx"] -= (data[? "width"] + data[? "paddingLeft"] + data[? "paddingRight"]) * .5 - 1;
		break;
}

if (hasParent)
{
	if (parent[? "grid"] == "row")
	{
		data[? "xx"] -= parent[? "width"] * .5;
		
		for (var i=0; i<parentChildrenSize; i++) //size of current rows
		{
			var child = parentChildren[| i];
			if (child == data)
			{
				data[? "xx"] += child[? "widthPercent"] * parent[? "width"] * .5;
				break;
			}
			else
			{
				data[? "xx"] += child[? "widthPercent"] * parent[? "width"];
			}
		}
	}
	
	data[? "xx"] += parent[? "xx"];
	
	data[? "xx"] += data[? "paddingLeft"] * .5;
	data[? "xx"] -= data[? "paddingRight"] * .5;
	data[? "xx"] += data[? "marginLeft"] * .5;
	data[? "xx"] -= data[? "marginRight"] * .5;
}

#endregion
#region yy

if (!ds_map_exists(data, "yy"))
{
	data[? "yy"] = 0;
}

//TODO -1
switch (data[? "vAnchor"])
{
	case fa_top:
		data[? "yy"] += (data[? "height"] + data[? "paddingTop"] + data[? "paddingBottom"]) * .5 - 1;
		break;
		
	case fa_middle:
		data[? "yy"] += 0;
		break;
		
	case fa_bottom:
		data[? "yy"] -= (data[? "height"] + data[? "paddingTop"] + data[? "paddingBottom"]) * .5 - 1;
		break;
}

if (parent != -1)
{
	if (parent[? "grid"] == "column")
	{
		data[? "yy"] -= parent[? "height"] * .5;
		
		for (var i=0; i<parentChildrenSize; i++) //size of current rows
		{
			var child = parentChildren[| i];
			if (child == data)
			{
				data[? "yy"] += child[? "heightPercent"] * parent[? "height"] * .5;
				break;
			}
			else
			{
				data[? "yy"] += child[? "heightPercent"] * parent[? "height"];
			}
		}
	}
	
	data[? "yy"] += parent[? "yy"];
	
	data[? "yy"] += data[? "paddingTop"] * .5;
	data[? "yy"] -= data[? "paddingBottom"] * .5;
	data[? "yy"] += data[? "marginTop"] * .5;
	data[? "yy"] -= data[? "marginBottom"] * .5;
}

#endregion
#region sprite cover

if (!ds_map_exists(data, "spriteCover"))
{
	data[? "spriteCover"] = false;
}
else if (data[? "sprite"] = "")
{
	show_error("spriteCover doesn't make much sense without a sprite", true);
}

#endregion
#region image xscale

if (!ds_map_exists(data, "imageXscale"))
{
	if (data[? "spriteCover"])
	{
		data[? "imageXscale"] = data[? "width"] / spriteWidth;
	}
	else
	{
		data[? "imageXscale"] = 1;
	}
}
else if (data[? "spriteCover"])
{
	show_error("imageXscale overwritten by spriteCover", true);
}

#endregion
#region image yscale

if (!ds_map_exists(data, "imageYscale"))
{
	if (data[? "spriteCover"])
	{
		data[? "imageYscale"] = data[? "height"] / spriteHeight;
	}
	else
	{
		data[? "imageYscale"] = 1;
	}
}
else if (data[? "spriteCover"])
{
	show_error("imageYscale overwritten by spriteCover", true);
}

#endregion
#region horizontal align

if (!ds_map_exists(data, "hAlign"))
{
	data[? "hAlign"] = fa_center;
}

#endregion
#region vertical align

if (!ds_map_exists(data, "vAlign"))
{
	data[? "vAlign"] = fa_middle;
}

#endregion
#region fill color

if (!ds_map_exists(data, "fillColor"))
{
	data[? "fillColor"] = c_modern_black;
}

#endregion
#region fill alpha

if (!ds_map_exists(data, "fillAlpha"))
{
	data[? "fillAlpha"] = 0;
}
else if (data[? "fillAlpha"] == -1)
{
	data[? "fillAlpha"] = .8;
}

#endregion
#region radius

if (!ds_map_exists(data, "radius"))
{
	data[? "radius"] = 0;
}
else if (data[? "radius"] == -1)
{
	var smaller = min(data[? "width"], data[? "height"]);
	var larger = max(data[? "width"], data[? "height"]);
			
	var ratio = smaller / larger;
	var mag = magnitude(data[? "width"], data[? "height"]);
			
	data[? "radius"] = round(ratio * mag * .5);
}

#endregion
#region text color

if (!ds_map_exists(data, "textColor"))
{
	data[? "textColor"] = c_white;
}

#endregion
#region text alpha

if (!ds_map_exists(data, "textAlpha"))
{
	data[? "textAlpha"] = 1;
}

#endregion
#region shadow color

if (!ds_map_exists(data, "shadowColor"))
{
	data[? "shadowColor"] = c_black;
}

#endregion
#region shadow alpha

if (!ds_map_exists(data, "shadowAlpha"))
{
	data[? "shadowAlpha"] = data[? "textAlpha"];
}

#endregion
#region border color

if (!ds_map_exists(data, "borderColor"))
{
	data[? "borderColor"] = c_white;
}

#endregion
#region border alpha

if (!ds_map_exists(data, "borderAlpha"))
{
	data[? "borderAlpha"] = 0;
}

#endregion
#region draw

var halfWidth = data[? "width"] * .5;
var halfHeight = data[? "height"] * .5;

var spriteHalfWidth = 0;
var spriteHalfHeight = 0;

if (data[? "sprite"] != "")
{
	if (data[? "spriteCover"])
	{
		spriteHalfWidth = spriteWidth * .5 * data[? "imageXscale"];
		spriteHalfHeight = spriteHeight * .5 * data[? "imageYscale"];
	}
	else
	{
		spriteHalfWidth = spriteWidth * .5;
		spriteHalfHeight = spriteHeight * .5;
	}
}

var x1 = data[? "xx"] - halfWidth - data[? "paddingLeft"];
var y1 = data[? "yy"] - halfHeight - data[? "paddingTop"];

var x2 = data[? "xx"] + halfWidth + data[? "paddingRight"];
var y2 = data[? "yy"] + halfHeight + data[? "paddingBottom"];

if (data[? "fillAlpha"] != 0)
{
	draw_set_alpha(data[? "fillAlpha"]);
	draw_set_color(data[? "fillColor"]);
	draw_roundrect_ext(x1, y1, x2, y2, data[? "radius"], data[? "radius"], false);
}

if (data[? "borderAlpha"] != 0)
{
	draw_set_alpha(data[? "borderAlpha"]);
	draw_set_color(data[? "borderColor"]);
	draw_roundrect_ext(x1, y1, x2, y2, data[? "radius"], data[? "radius"], true);
}

var startX;
var startY;

var spriteX;
var spriteY;

//TODO +1
switch (data[? "hAlign"])
{
	case fa_left:
		startX = data[? "xx"] - halfWidth + 1;
		spriteX = startX + spriteHalfWidth;
		break;
		
	case fa_center:
		startX = data[? "xx"] + 1;
		spriteX = startX
		break;
		
	case fa_right:
		startX = data[? "xx"] + halfWidth + 1;
		spriteX = startX - spriteHalfWidth;
		break;
}

//TODO +2
switch (data[? "vAlign"])
{
	case fa_top:
		startY = data[? "yy"] - halfHeight + 2;
		spriteY = startY + spriteHalfHeight;
		break;
		
	case fa_middle:
		startY = data[? "yy"] + 2;
		spriteY = startY;
		break;
		
	case fa_bottom:
		startY = data[? "yy"] + halfHeight + 2;
		spriteY = startY - spriteHalfHeight;
		break;
}

if (data[? "sprite"] != "" && data[? "imageIndex"] != -1 && data[? "imageAlpha"] > 0)
{	
	draw_sprite_ext(data[? "sprite"], data[? "imageIndex"], spriteX, spriteY, data[? "imageXscale"], data[? "imageYscale"], data[? "imageRotation"], data[? "imageColor"], data[? "imageAlpha"]);
}

if (data[? "str"] != "")
{
	draw_set_halign(data[? "hAlign"]);
	draw_set_valign(data[? "vAlign"]);

	var hashStr = string_hash_to_newline(data[? "str"]);

	if (data[? "shadowAlpha"] > 0)
	{
		draw_set_alpha(data[? "shadowAlpha"]);
		draw_set_color(data[? "shadowColor"]);

		draw_text_ext(startX - 1, startY - 1, hashStr, data[? "lineHeight"], data[? "width"]);
		draw_text_ext(startX - 1, startY + 1, hashStr, data[? "lineHeight"], data[? "width"]);
		draw_text_ext(startX + 1, startY - 1, hashStr, data[? "lineHeight"], data[? "width"]);
		draw_text_ext(startX + 1, startY + 1, hashStr, data[? "lineHeight"], data[? "width"]);
	}

	if (data[? "textAlpha"] > 0)
	{
		draw_set_alpha(data[? "textAlpha"]);
		draw_set_color(data[? "textColor"]);

		draw_text_ext(startX, startY, hashStr, data[? "lineHeight"], data[? "width"]);
	}
}

//reset
draw_reset_font_and_color();
draw_set_color(prevColor);
draw_set_alpha(prevAlpha);

#endregion
#region recurse

if (childrenSize > 0)
{
	var percent = 0;
	
	for (var i=0; i<childrenSize; i++)
	{
		var child = children[| i];
		
		draw_container(child);
		
		if (data[? "grid"] == "column")
		{
			percent += child[? "heightPercent"];
		}
		else if (data[? "grid"] == "row")
		{
			percent += child[? "widthPercent"];
		}
	}

	if (percent != 1)
	{
		show_error("Percentage should add to 1, actual value is " + string(percent), true);
	}
}

#endregion
#region finale

//end recursion
if (!hasParent)
{
	ds_map_destroy(data);
}

#endregion