/// @description container_get_height_percent(data)
/// @param data
function container_get_height_percent(data)
{
	var parent = data.parent;
	if (parent == -1)
	{
		return 1;	
	}

	var outside = data.marginTop + data.marginBottom + data.paddingTop + data.paddingBottom;
	return (outside + data.renderHeight) / parent.renderHeight;
}