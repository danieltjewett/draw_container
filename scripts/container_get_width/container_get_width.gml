/// @description container_get_width(data)
/// @param data
function container_get_width(data)
{
	return data.computedWidth - data.marginLeft - data.marginRight - data.paddingLeft - data.paddingRight;
}