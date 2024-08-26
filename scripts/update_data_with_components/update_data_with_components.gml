function update_data_with_components(data)
{
	data.components = get_components(data.str);
	data.plaintext = string_join_ext("", data.components);
}