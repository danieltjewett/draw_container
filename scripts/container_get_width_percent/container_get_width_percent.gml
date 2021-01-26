/// @description container_get_width_percent(data)
/// @param data
function container_get_width_percent(data)
{
	var parent = data.parent;
	if (parent == -1)
	{
		return 1;	
	}

	var outside = data.marginLeft + data.marginRight + data.paddingLeft + data.paddingRight;
	return (outside + data.width) / parent.width;
}