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
	
	var dataParentStructExists = variable_struct_exists(data, "parent");
	
	if (!dataParentStructExists || data.parent == -1)
	{
		//we still need to set parent for optimized properties.  This will do that.
		//first time, need to build the entire structure
		if (!dataParentStructExists)
		{
			draw_container_get_properties(data);
		}
		
		draw_container_calculate(data);
	}
	else
	{
		hasParent = true;
		parent = data.parent;
	
		parentChildren = parent.children;
		parentChildrenSize = array_length(parentChildren);
	}
	
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

	data.renderWidth = data.width;
	if (data.width == -1)
	{
		if (!hasParent)
		{
			if (data.flow == "fill" || data.flow == "stack")
			{
				data.renderWidth = container_get_width(data);
				data.widthPercent = container_get_width_percent(data);
			}
			else if (data.flow == "split")
			{
				data.renderWidth = data.strWidth;
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
				
						data.renderWidth = 1 - percent;
					}
					else
					{
						data.renderWidth = container_get_width(data);
						data.widthPercent = container_get_width_percent(data);
					}
				}
				else
				{
					data.renderWidth = 1;
				}
			}
			else if (parent.flow == "split")
			{
				if (parent.grid == "row")
				{
					data.renderWidth = 1 / parentChildrenSize;
				}
				else
				{
					data.renderWidth = 1;
				}
			}
			else if (parent.flow == "stack")
			{
				data.renderWidth = parent.renderWidth;
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

	if (data.renderWidth <= 1) //percentage
	{
		data.widthPercent = data.renderWidth;
		data.renderWidth = (parent.renderWidth * data.renderWidth) - data.marginLeft - data.marginRight - data.paddingLeft - data.paddingRight;
	}

	#endregion
	#region height

	data.renderHeight = data.height;
	if (data.height == -1)
	{
		if (!hasParent)
		{
			if (data.flow == "fill" || data.flow == "stack")
			{
				data.renderHeight = container_get_height(data);
				data.heightPercent = container_get_height_percent(data);
			}
			else if (data.flow == "split")
			{
				data.renderHeight = data.strHeight;
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
				
						data.renderHeight = 1 - percent;
					}
					else
					{
						data.renderHeight = container_get_height(data);
						data.heightPercent = container_get_height_percent(data);
					}
				}
				else
				{
					data.renderHeight = 1;
				}
			}
			else if (parent.flow == "split")
			{
				if (parent.grid == "column")
				{
					data.renderHeight = 1 / parentChildrenSize;
				}
				else
				{
					data.renderHeight = 1;
				}
			}
			else if (parent.flow == "stack")
			{
				data.renderHeight = parent.renderHeight;
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

	if (data.renderHeight <= 1) //percentage
	{
		data.heightPercent = data.renderHeight;
		data.renderHeight = (parent.renderHeight * data.renderHeight) - data.marginTop - data.marginBottom - data.paddingTop - data.paddingBottom;
	}

	#endregion
	#region x

	switch (data.hAnchor)
	{
		case fa_left:
			data.renderX = data.x + (data.renderWidth + data.paddingLeft + data.paddingRight) * .5;
			break;
		
		case fa_center:
			data.renderX = data.x;
			break;
		
		case fa_right:
			data.renderX = data.x - (data.renderWidth + data.paddingLeft + data.paddingRight) * .5;
			break;
	}

	if (hasParent)
	{
		if (parent.grid == "row" && parent.flow != "stack")
		{
			data.renderX -= parent.renderWidth * .5;
		
			for (var i=0; i<parentChildrenSize; i++) //size of current rows
			{
				var child = parentChildren[i];
				if (child == data)
				{
					data.renderX += child.widthPercent * parent.renderWidth * .5;
					break;
				}
				else
				{
					data.renderX += child.widthPercent * parent.renderWidth;
				}
			}
		}
	
		data.renderX += parent.renderX;
		
		data.renderX += data.paddingLeft * .5;
		data.renderX -= data.paddingRight * .5;
		data.renderX += data.marginLeft * .5;
		data.renderX -= data.marginRight * .5;
	}

	#endregion
	#region y

	switch (data.vAnchor)
	{
		case fa_top:
			data.renderY = data.y + (data.renderHeight + data.paddingTop + data.paddingBottom) * .5;
			break;
		
		case fa_middle:
			data.renderY = data.y;
			break;
		
		case fa_bottom:
			data.renderY = data.y - (data.renderHeight + data.paddingTop + data.paddingBottom) * .5;
			break;
	}

	if (parent != -1)
	{
		if (parent.grid == "column" && parent.flow != "stack")
		{
			data.renderY -= parent.renderHeight * .5;
		
			for (var i=0; i<parentChildrenSize; i++) //size of current rows
			{
				var child = parentChildren[i];
				if (child == data)
				{
					data.renderY += child.heightPercent * parent.renderHeight * .5;
					break;
				}
				else
				{
					data.renderY += child.heightPercent * parent.renderHeight;
				}
			}
		}
	
		data.renderY += parent.renderY;
		
		data.renderY += data.paddingTop * .5;
		data.renderY -= data.paddingBottom * .5;
		data.renderY += data.marginTop * .5;
		data.renderY -= data.marginBottom * .5;
	}

	#endregion
	#region draw
	
	//override scales
	if (data.spriteCover)
	{
		data.imageXscale = (data.renderWidth + data.paddingLeft + data.paddingRight) / spriteWidth;
		data.imageYscale = (data.renderHeight + data.paddingTop + data.paddingBottom) / spriteHeight;
	}
	//
	
	//override radius
	if (data.radius == -1)
	{
		var smaller = min(data.renderWidth, data.renderHeight);
		var larger = max(data.renderWidth, data.renderHeight);
			
		var ratio = smaller / larger;
		var mag = magnitude(data.renderWidth, data.renderHeight);
			
		data.radius = round(ratio * mag * .5);
	}
	//

	var halfWidth = data.renderWidth * .5;
	var halfHeight = data.renderHeight * .5;

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

	var x1 = data.renderX - halfWidth - data.paddingLeft;
	var y1 = data.renderY - halfHeight - data.paddingTop;

	var x2 = data.renderX + halfWidth + data.paddingRight;
	var y2 = data.renderY + halfHeight + data.paddingBottom;
	
	if (data.shaderFunc != -1)
	{
		data.shaderFunc();	
	}

	if (data.fillAlpha != 0 && data.computedOpacity != 0)
	{
		draw_set_alpha(data.fillAlpha * data.computedOpacity);
		draw_set_color(data.fillColor);
		draw_roundrect_ext(x1 - 1, y1 - 1, x2 - 1, y2 - 1, data.radius, data.radius, false);
	}

	if (data.borderAlpha != 0 && data.computedOpacity != 0)
	{
		draw_set_alpha(data.borderAlpha * data.computedOpacity);
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
			startX = data.renderX - halfWidth;
			spriteX = startX + spriteHalfWidth;
			break;
		
		case fa_center:
			startX = data.renderX;
			spriteX = startX;
			break;
		
		case fa_right:
			startX = data.renderX + halfWidth;
			spriteX = startX - spriteHalfWidth;
			break;
	}

	switch (data.vAlign)
	{
		case fa_top:
			startY = data.renderY - halfHeight;
			spriteY = startY + spriteHalfHeight;
			break;
		
		case fa_middle:
			startY = data.renderY;
			spriteY = startY;
			break;
		
		case fa_bottom:
			startY = data.renderY + halfHeight;
			spriteY = startY - spriteHalfHeight;
			break;
	}

	if (data.sprite != -1 && data.imageIndex != -1 && data.imageAlpha != 0 && data.computedOpacity != 0)
	{
		draw_sprite_ext(
			data.sprite,
			data.imageIndex,
			spriteX - (data.paddingLeft * .5) + (data.paddingRight * .5),
			spriteY - (data.paddingTop * .5) + (data.paddingBottom * .5),
			data.imageXscale,
			data.imageYscale,
			data.imageRotation,
			data.imageColor,
			data.imageAlpha * data.computedOpacity
		);
	}
			
	draw_set_halign(data.hAlign);
	draw_set_valign(data.vAlign);
		
	draw_set_font(data.font);
	
	var lines = data.useCache ? data.segments : container_get_lines(data);
	
	var total_lines = array_length(lines);
	
	for (var line_index = 0; line_index < array_length(lines); line_index++)
	{
		
		var line_width = lines[line_index].width;
		var left_width = 0;
		var right_width = line_width;
		
		for (var i = 0; i < array_length(lines[line_index].segments); i++)
		{
			
			var segment = lines[line_index].segments[i];
			
			var text_to_draw = segment.contents;
			
			if (text_to_draw != "")
			{
				
				var size_of_segment = string_width(text_to_draw);
				right_width -= string_width(text_to_draw);
				var width_offset;
				
				var halign = draw_get_halign();
	
				if (halign == fa_right)
				{
					width_offset = -right_width;
				}
				else if (halign == fa_center)
				{
					width_offset = (left_width-right_width)/2;
				}
				else
				{
					width_offset = left_width; // fa_left or undefined
				}
				
				text_to_draw = string_repeat("\n", line_index) + text_to_draw + string_repeat("\n", (total_lines - line_index));
				
				if (data.shadowAlpha != 0 && data.computedOpacity != 0)
				{
					draw_set_alpha(data.shadowAlpha * data.computedOpacity);
					draw_set_color(data.shadowColor);
			
					//TODO wonky fade outs with all of these shadows
			
					//thin perp shadows
					draw_text_ext(startX + width_offset - 1, startY, text_to_draw, data.lineHeight, data.renderWidth);
					draw_text_ext(startX + width_offset + 1, startY, text_to_draw, data.lineHeight, data.renderWidth);
					draw_text_ext(startX + width_offset, startY - 1, text_to_draw, data.lineHeight, data.renderWidth);
					draw_text_ext(startX + width_offset, startY + 1, text_to_draw, data.lineHeight, data.renderWidth);
			
					//diag thicker shadows
					draw_text_ext(startX - 1 + width_offset, startY - 1, text_to_draw, data.lineHeight, data.renderWidth);
					draw_text_ext(startX - 1 + width_offset, startY + 1, text_to_draw, data.lineHeight, data.renderWidth);
					draw_text_ext(startX + 1 + width_offset, startY - 1, text_to_draw, data.lineHeight, data.renderWidth);
					draw_text_ext(startX + 1 + width_offset, startY + 1, text_to_draw, data.lineHeight, data.renderWidth);
				}

				if (data.textAlpha != 0 && data.computedOpacity != 0)
				{
					draw_set_alpha(data.textAlpha * data.computedOpacity);
					if (segment.emphasis)
					{
						draw_set_color(data.emphasisColor);
					}
					else
					{
						draw_set_color(data.textColor);
					}

					draw_text_ext(startX + width_offset, startY, text_to_draw, data.lineHeight, data.renderWidth);
				}
			
				left_width += string_width(text_to_draw);
			
			}
			
		}
		
	}
	
	if (data.shaderFunc != -1)
	{
		shader_reset();
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
}