/// @description draw_container(data) See documenation at https://github.com/danieltjewett/draw_container
/// @param data
function draw_container(data)
{	
	var prevAlpha = draw_get_alpha();
	var prevColor = draw_get_color();
	
	//parent section
	var hasParent = false;
	var parent = -1;

	var parentChildren = -1;
	var parentChildrenSize = 0;
	
	if (!variable_struct_exists(data, "parent"))
	{
		//first time, need to build the entire structure
		draw_container_get_properties(data);
		draw_container_calculate(data);
	}
	else
	{
		hasParent = true;
		parent = data.parent;
	
		parentChildren = parent.children;
		parentChildrenSize = array_length(parentChildren);
	}
	//
	
	#region sprite

	var spriteWidth = 0;
	var spriteHeight = 0;

	if (data.sprite != -1)
	{
		spriteWidth = sprite_get_width(data.sprite);
		spriteHeight = sprite_get_height(data.sprite);
	}

	#endregion
	#region width

	if (data.width == -1)
	{
		if (!hasParent)
		{
			if (data.flow == "fill" || data.flow == "stack")
			{
				data.width = container_get_width(data);
				data.widthPercent = container_get_width_percent(data);
			}
			else if (data.flow == "split")
			{
				data.width = data.strWidth;
				data.widthPercent = 1;
			}
			else
			{
				throw "Unknown flow property, " + data.flow;
			}
		}
		else
		{
			if (parent.flow == "fill")
			{
				if (parent.grid == "row")
				{
					//if we are on the last child, sum up current percentages and 1 - the percent is the remainder
					if (parentChildren[parentChildrenSize - 1] == data)
					{
						var percent = 0;
						for (var i=0; i<parentChildrenSize - 1; i++)
						{
							var child = parentChildren[i];
							percent += child.widthPercent;
						}
				
						data.width = 1 - percent;
					}
					else
					{
						data.width = container_get_width(data);
						data.widthPercent = container_get_width_percent(data);
					}
				}
				else
				{
					data.width = 1;
				}
			}
			else if (parent.flow == "split")
			{
				if (parent.grid == "row")
				{
					data.width = 1 / parentChildrenSize;
				}
				else
				{
					data.width = 1;
				}
			}
			else if (parent.flow == "stack")
			{
				data.width = parent.width;
				data.widthPercent = 1;
			}
			else
			{
				throw "Unknown flow property, " + parent.flow;
			}
		}
	}
	else if (data.width > 1)
	{
		if (hasParent)
		{
			data.widthPercent = container_get_width_percent(data);
		}
		else
		{
			data.widthPercent = 1;
		}
	}

	if (data.width <= 1) //percentage
	{
		data.widthPercent = data.width;
		data.width = (parent.width * data.width) - data.marginLeft - data.marginRight - data.paddingLeft - data.paddingRight;
	}

	#endregion
	#region height

	if (data.height == -1)
	{
		if (!hasParent)
		{
			if (data.flow == "fill" || data.flow == "stack")
			{
				data.height = container_get_height(data);
				data.heightPercent = container_get_height_percent(data);
			}
			else if (data.flow == "split")
			{
				data.height = data.strHeight;
				data.heightPercent = 1;
			}
			else
			{
				throw "Unknown flow property, " + data.flow;
			}
		}
		else
		{
			if (parent.flow == "fill")
			{
				if (parent.grid == "column")
				{
					//if we are on the last child, sum up current percentages and 1 - the percent is the remainder
					if (parentChildren[parentChildrenSize - 1] == data)
					{
						var percent = 0;
						for (var i=0; i<parentChildrenSize - 1; i++)
						{
							var child = parentChildren[i];
							percent += child.heightPercent;
						}
				
						data.height = 1 - percent;
					}
					else
					{
						data.height = container_get_height(data);
						data.heightPercent = container_get_height_percent(data);
					}
				}
				else
				{
					data.height = 1;
				}
			}
			else if (parent.flow == "split")
			{
				if (parent.grid == "column")
				{
					data.height = 1 / parentChildrenSize;
				}
				else
				{
					data.height = 1;
				}
			}
			else if (parent.flow == "stack")
			{
				data.height = parent.height;
				data.heightPercent = 1;
			}
			else
			{
				throw "Unknown flow property, " + parent.flow;
			}
		}
	}
	else if (data.height > 1)
	{
		if (hasParent)
		{
			data.heightPercent = container_get_height_percent(data);
		}
		else
		{
			data.heightPercent = 1;
		}
	}

	if (data.height <= 1) //percentage
	{
		data.heightPercent = data.height;
		data.height = (parent.height * data.height) - data.marginTop - data.marginBottom - data.paddingTop - data.paddingBottom;
	}

	#endregion
	#region x

	switch (data.hAnchor)
	{
		case fa_left:
			data.x += (data.width + data.paddingLeft + data.paddingRight) * .5;
			break;
		
		case fa_center:
			data.x += 0;
			break;
		
		case fa_right:
			data.x -= (data.width + data.paddingLeft + data.paddingRight) * .5;
			break;
	}

	if (hasParent)
	{
		if (parent.grid == "row" && parent.flow != "stack")
		{
			data.x -= parent.width * .5;
		
			for (var i=0; i<parentChildrenSize; i++) //size of current rows
			{
				var child = parentChildren[i];
				if (child == data)
				{
					data.x += child.widthPercent * parent.width * .5;
					break;
				}
				else
				{
					data.x += child.widthPercent * parent.width;
				}
			}
		}
	
		data.x += parent.x;
		
		data.x += data.paddingLeft * .5;
		data.x -= data.paddingRight * .5;
		data.x += data.marginLeft * .5;
		data.x -= data.marginRight * .5;
	}

	#endregion
	#region y

	switch (data.vAnchor)
	{
		case fa_top:
			data.y += (data.height + data.paddingTop + data.paddingBottom) * .5;
			break;
		
		case fa_middle:
			data.y += 0;
			break;
		
		case fa_bottom:
			data.y -= (data.height + data.paddingTop + data.paddingBottom) * .5;
			break;
	}

	if (parent != -1)
	{
		if (parent.grid == "column" && parent.flow != "stack")
		{
			data.y -= parent.height * .5;
		
			for (var i=0; i<parentChildrenSize; i++) //size of current rows
			{
				var child = parentChildren[i];
				if (child == data)
				{
					data.y += child.heightPercent * parent.height * .5;
					break;
				}
				else
				{
					data.y += child.heightPercent * parent.height;
				}
			}
		}
	
		data.y += parent.y;
		
		data.y += data.paddingTop * .5;
		data.y -= data.paddingBottom * .5;
		data.y += data.marginTop * .5;
		data.y -= data.marginBottom * .5;
	}

	#endregion
	#region draw
	
	//override scales
	if (data.spriteCover)
	{
		data.imageXscale = data.width / spriteWidth;
		data.imageYscale = data.height / spriteHeight;
	}
	//
	
	//override radius
	if (data.radius == -1)
	{
		var smaller = min(data.width, data.height);
		var larger = max(data.width, data.height);
			
		var ratio = smaller / larger;
		var mag = magnitude(data.width, data.height);
			
		data.radius = round(ratio * mag * .5);
	}
	//

	var halfWidth = data.width * .5;
	var halfHeight = data.height * .5;

	var spriteHalfWidth = 0;
	var spriteHalfHeight = 0;

	if (data.sprite != -1)
	{
		if (data.spriteCover)
		{
			spriteHalfWidth = spriteWidth * .5 * data.imageXscale;
			spriteHalfHeight = spriteHeight * .5 * data.imageYscale;
		}
		else
		{
			spriteHalfWidth = spriteWidth * .5;
			spriteHalfHeight = spriteHeight * .5;
		}
	}

	var x1 = data.x - halfWidth - data.paddingLeft;
	var y1 = data.y - halfHeight - data.paddingTop;

	var x2 = data.x + halfWidth + data.paddingRight;
	var y2 = data.y + halfHeight + data.paddingBottom;

	if (data.fillAlpha != 0)
	{
		draw_set_alpha(data.fillAlpha);
		draw_set_color(data.fillColor);
		draw_roundrect_ext(x1 - 1, y1 - 1, x2 - 1, y2 - 1, data.radius, data.radius, false);
	}

	if (data.borderAlpha != 0)
	{
		draw_set_alpha(data.borderAlpha);
		draw_set_color(data.borderColor);
		draw_roundrect_ext(x1, y1, x2 - 2, y2 - 2, data.radius, data.radius, true);
	}

	var startX;
	var startY;

	var spriteX;
	var spriteY;

	switch (data.hAlign)
	{
		case fa_left:
			startX = data.x - halfWidth;
			spriteX = startX + spriteHalfWidth;
			break;
		
		case fa_center:
			startX = data.x;
			spriteX = startX;
			break;
		
		case fa_right:
			startX = data.x + halfWidth;
			spriteX = startX - spriteHalfWidth;
			break;
	}

	switch (data.vAlign)
	{
		case fa_top:
			startY = data.y - halfHeight;
			spriteY = startY + spriteHalfHeight;
			break;
		
		case fa_middle:
			startY = data.y;
			spriteY = startY;
			break;
		
		case fa_bottom:
			startY = data.y + halfHeight;
			spriteY = startY - spriteHalfHeight;
			break;
	}

	if (data.sprite != -1 && data.imageIndex != -1 && data.imageAlpha > 0)
	{	
		draw_sprite_ext(data.sprite, data.imageIndex, spriteX, spriteY, data.imageXscale, data.imageYscale, data.imageRotation, data.imageColor, data.imageAlpha);
	}

	if (data.str != "")
	{
		draw_set_halign(data.hAlign);
		draw_set_valign(data.vAlign);
		
		draw_set_font(data.font);

		var hashStr = string_hash_to_newline(data.str);

		if (data.shadowAlpha > 0)
		{			
			draw_set_alpha(data.shadowAlpha);
			draw_set_color(data.shadowColor);
			
			draw_text_ext(startX - 1, startY - 1, hashStr, data.lineHeight, data.width);
			draw_text_ext(startX - 1, startY + 1, hashStr, data.lineHeight, data.width);
			draw_text_ext(startX + 1, startY - 1, hashStr, data.lineHeight, data.width);
			draw_text_ext(startX + 1, startY + 1, hashStr, data.lineHeight, data.width);
		}

		if (data.textAlpha > 0)
		{
			draw_set_alpha(data.textAlpha);
			draw_set_color(data.textColor);

			draw_text_ext(startX, startY, hashStr, data.lineHeight, data.width);
		}
	}

	//reset
	draw_reset_font_and_color();
	draw_set_color(prevColor);
	draw_set_alpha(prevAlpha);

	#endregion
	#region recurse

	var childrenSize = array_length(data.children);
	
	if (childrenSize > 0)
	{
		var percent = 0;
	
		for (var i=0; i<childrenSize; i++)
		{
			var child = data.children[i];
		
			draw_container(child);
		
			if (data.grid == "column")
			{
				percent += child.heightPercent;
			}
			else if (data.grid == "row")
			{
				percent += child.widthPercent;
			}
		}

		if (percent != 1 && data.flow != "stack" && data.requireFull)
		{
			var errStr = "";
			if (data.grid == "column")
			{
				errStr = "Height";
			}
			else if (data.grid == "row")
			{
				errStr = "Width";
			}
		
			throw errStr + " Percentage should add to 1, actual value is " + string(percent);
		}
	}

	#endregion
	#region finale

	//end recursion
	if (!hasParent)
	{
		delete data;
	}

	#endregion
}