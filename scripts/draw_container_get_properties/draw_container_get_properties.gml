/// @description draw_container_get_properties(data) Gets all the properties for a container, for optimization
/// @param data
function draw_container_get_properties(data)
{	
	//children section
	var hasChildren = false;
	var childrenSize = 0;
	
	if (variable_struct_exists(data, "children"))
	{
		childrenSize = array_length(data.children);
	
		hasChildren = childrenSize > 0;
	}
	else
	{
		data.children = [];	
	}
	//
	
	//parent section
	var hasParent = false;
	var parent = -1;
	
	if (variable_struct_exists(data, "parent"))
	{
		hasParent = true;
		parent = data.parent;
	}
	else
	{
		data.parent = -1;
	}
	//
	
	//optimize and automatically add properties now, so when we recurse, we don't do this tons of times unnecessarily
	if (!variable_struct_exists(data, "x"))
	{
		data.x = 0;
	}
	
	if (!variable_struct_exists(data, "y"))
	{
		data.y = 0;
	}
	
	if (!variable_struct_exists(data, "flow"))
	{
		data.flow = "fill";
	}
	
	if (!variable_struct_exists(data, "opacity"))
	{
		data.opacity = 1;
	}
	
	if (!variable_struct_exists(data, "margin"))
	{
		if (!variable_struct_exists(data, "marginLeft"))
		{
			data.marginLeft = 0;
		}
		else if (!hasParent)
		{
			throw "marginLeft doesn't really do anything to root";
		}
		
		if (!variable_struct_exists(data, "marginTop"))
		{
			data.marginTop = 0;
		}
		else if (!hasParent)
		{
			throw "marginTop doesn't really do anything to root";
		}
		
		if (!variable_struct_exists(data, "marginRight"))
		{
			data.marginRight = 0;
		}
		else if (!hasParent)
		{
			throw "marginRight doesn't really do anything to root";
		}
		
		if (!variable_struct_exists(data, "marginBottom"))
		{
			data.marginBottom = 0;
		}
		else if (!hasParent)
		{
			throw "marginBottom doesn't really do anything to root";
		}
	}
	else
	{
		if (!hasParent)
		{
			throw "margin doesn't really do anything to root";
		}
		else
		{
			data.marginLeft = data.margin;
			data.marginTop = data.margin;
			data.marginRight = data.margin;
			data.marginBottom = data.margin;
		}
	}
	
	if (!variable_struct_exists(data, "padding"))
	{
		if (!variable_struct_exists(data, "paddingLeft"))
		{
			data.paddingLeft = 0;
		}
		if (!variable_struct_exists(data, "paddingTop"))
		{
			data.paddingTop = 0;
		}
		if (!variable_struct_exists(data, "paddingRight"))
		{
			data.paddingRight = 0;
		}
		if (!variable_struct_exists(data, "paddingBottom"))
		{
			data.paddingBottom = 0;
		}
	}
	else
	{
		data.paddingLeft = data.padding;
		data.paddingTop = data.padding;
		data.paddingRight = data.padding;
		data.paddingBottom = data.padding;
	}
	
	if (!variable_struct_exists(data, "width"))
	{
		data.width = -1;
	}
	
	if (!variable_struct_exists(data, "height"))
	{
		data.height = -1;
	}
	
	if (!variable_struct_exists(data, "requireFull"))
	{
		data.requireFull = true;
	}
	
	if (!variable_struct_exists(data, "str"))
	{
		data.str = "";
	}
	
	if (!variable_struct_exists(data, "font"))
	{
		data.font = font_Arial8;
	}
	
	if (!variable_struct_exists(data, "lineHeight"))
	{
		data.lineHeight = -1;
	}
	
	if (!variable_struct_exists(data, "hAnchor"))
	{
		data.hAnchor = fa_center;
	}
	
	if (!variable_struct_exists(data, "vAnchor"))
	{
		data.vAnchor = fa_middle;
	}
	
	if (!variable_struct_exists(data, "hAlign"))
	{
		data.hAlign = fa_center;
	}
	
	if (!variable_struct_exists(data, "vAlign"))
	{
		data.vAlign = fa_middle;
	}
	
	if (!variable_struct_exists(data, "sprite"))
	{
		data.sprite = -1;
	}
	
	if (!variable_struct_exists(data, "imageIndex"))
	{
		data.imageIndex = 0;
	}
	
	if (!variable_struct_exists(data, "imageRotation"))
	{
		data.imageRotation = 0;
	}
	
	if (!variable_struct_exists(data, "imageColor"))
	{
		data.imageColor = -1;
	}
	
	if (!variable_struct_exists(data, "imageAlpha"))
	{
		data.imageAlpha = 1;
	}
	
	if (!variable_struct_exists(data, "spriteCover"))
	{
		data.spriteCover = false;
	}
	else if (data.sprite == -1)
	{
		throw "spriteCover doesn't make much sense without a sprite";
	}
	
	if (!variable_struct_exists(data, "imageXscale"))
	{
		data.imageXscale = 1;
	}
	else if (data.spriteCover)
	{
		throw "imageXscale overwritten by spriteCover";
	}
	
	if (!variable_struct_exists(data, "imageYscale"))
	{
		data.imageYscale = 1;
	}
	else if (data.spriteCover)
	{
		throw "imageYscale overwritten by spriteCover";
	}
	
	if (!variable_struct_exists(data, "fillColor"))
	{
		data.fillColor = c_modern_black;
	}
	
	if (!variable_struct_exists(data, "fillAlpha"))
	{
		data.fillAlpha = 0;
	}
	else if (data.fillAlpha == -1)
	{
		data.fillAlpha = .8;
	}
	
	if (!variable_struct_exists(data, "radius"))
	{
		data.radius = 0;
	}
	
	if (!variable_struct_exists(data, "textColor"))
	{
		data.textColor = c_white;
	}
	
	if (!variable_struct_exists(data, "textAlpha"))
	{
		data.textAlpha = 1;
	}
	
	if (!variable_struct_exists(data, "shadowColor"))
	{
		data.shadowColor = c_black;
	}
	
	if (!variable_struct_exists(data, "shadowAlpha"))
	{
		data.shadowAlpha = 1;
	}
	
	if (!variable_struct_exists(data, "borderColor"))
	{
		data.borderColor = c_white;
	}
	
	if (!variable_struct_exists(data, "borderAlpha"))
	{
		data.borderAlpha = 0;
	}
	
	if (!variable_struct_exists(data, "shaderFunc"))
	{
		data.shaderFunc = -1;
	}
	
	if (hasChildren)
	{
		if (!hasParent)
		{
			if (!variable_struct_exists(data, "grid"))
			{
				throw "Root with children needs to specify a grid type";
			}
		}
		else
		{
			if (!variable_struct_exists(data, "grid"))
			{
				if (parent.grid == "column")
				{
					data.grid = "row";
				}	
				else if (parent.grid == "row")
				{
					data.grid = "column";
				}
			}
		}
		
		for (var i=0; i<childrenSize; i++)
		{
			var child = data.children[i];
			child.parent = data;
		
			draw_container_get_properties(child);
		}
	}
}