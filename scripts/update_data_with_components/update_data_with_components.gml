function update_data_with_components(data)
{
\tdata.components = get_components(data.str);
\tdata.plaintext = string_join_ext("", array_map(data.components, function(component) {
\t\treturn component.contents;
\t}));
}