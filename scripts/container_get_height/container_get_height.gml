/// @description container_get_height(data)
/// @param data
function container_get_height(data)
{
	return data.computedHeight - data.marginTop - data.marginBottom - data.paddingTop - data.paddingBottom;
}