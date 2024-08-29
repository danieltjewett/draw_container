function update_data_with_components(data)
{
	if (data.cachedComponentString != data.str || data.cachedComponentWidth != data.renderWidth)
	{ //if the components are cached, don't worry about it
		if (!struct_exists(data, "components"))
		{
			data.components = get_components(data.str);
		}
		if (!struct_exists(data, "plaintext"))
		{
			data.plaintext = string_join_ext("", array_map(data.components, function(component) {
				return component.contents;
			}));
		}
	}
}