/// @description draw_container_calculate(data)
/// @param data
function draw_container_calculate(data)
{	
	//parent section
	var hasParent = data.parent != -1;
	//
	
	//children section
	var children = data.children;
	var childrenSize = array_length(data.children);
	var hasChildren = childrenSize > 0;
	//
	
	//opacity section
	data.computedOpacity = hasParent ? data.parent.computedOpacity * data.opacity : data.opacity;
	//
	
	//recurse first
	for (var i=0; i<childrenSize; i++)
	{
		var child = children[i];
		draw_container_calculate(child);
	}
	
	draw_set_font(data.font);

	#region strWidth

	data.strWidth = string_width(data.str);

	#endregion
	#region strHeight

	var width = 0;
	var widthPercent = 1;
	
	var padding = 0;
	
	var current = data;
	
	if (data.str != "")
	{
		//walk up the parent to find a width to base computed height around
		while (current != -1 && width == 0)
		{
			if (current.width != -1)
			{
				width = current.width;
			
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
		
			padding += current.paddingLeft + current.paddingRight;
		
			current = current.parent;
		}
	}
	
	//if we find nothing, just use it's current width
	if (width == 0)
	{
		width = data.strWidth;
	}
	else if (hasParent) //take into account current margin width and total padding width, if it is not the root
	{
		width -= data.marginLeft + data.marginLeft + padding;
	}
	
	data.strHeight = string_height_ext(data.str, data.lineHeight, width);

	#endregion
	#region computed width

	var width;
	
	//integer width override content
	if (data.width > 1)
	{
		width = data.width;
	}
	else if (hasChildren)
	{
		width = 0;
	
		for (var i=0; i<childrenSize; i++)
		{
			var child = children[i];
			
			if (data.grid == "column")
			{
				width = max(width, child.computedWidth);
			}
			else
			{
				width += child.computedWidth;
			}
		}
	}
	else
	{
		width = data.strWidth;	
	}
	
	width += data.marginLeft + data.marginRight + data.paddingLeft + data.paddingRight;
	
	data.computedWidth = width;

	#endregion
	#region computed height

	var height;
	
	//integer heights override content
	if (data.height > 1)
	{
		height = data.height;
	}
	else if (hasChildren)
	{
		height = 0;
	
		for (var i=0; i<childrenSize; i++)
		{
			var child = children[i];
			
			if (data.grid == "row")
			{
				height = max(height, child.computedHeight);
			}
			else
			{
				height += child.computedHeight;
			}
		}
	}
	else
	{
		height = data.strHeight;	
	}
	
	height += data.marginTop + data.marginBottom + data.paddingTop + data.paddingBottom;
	
	data.computedHeight = height;

	#endregion
}