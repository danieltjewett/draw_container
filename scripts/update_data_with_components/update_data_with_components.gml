function update_data_with_components(data)
{
	if (data.cachedString != data.str ||
		data.cachedWidth != data.renderWidth ||
		data.cachedLength != data.len || //cached values have changed
		!struct_exists(data, "components") ||
		!struct_exists(data, "plaintext")) //one or more variables aren't defined
	{ //if the components are cached, don't worry about it
		data.components = get_components(data.str);
		data.plaintext = string_join_ext("", array_map(data.components, function(component) {
			return component.contents;
		}));
	}
}