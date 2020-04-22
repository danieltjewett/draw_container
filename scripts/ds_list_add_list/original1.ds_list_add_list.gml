/// @description ds_list_add_list(list, newList, [index=ds_list_size(list)-1])
/// @param list
/// @param newList
/// @param [index=ds_list_size(list)-1]

var list = argument[0];
var newList = argument[1];

ds_list_add(list, newList);

var index;
if (argument_count == 3)
{
	index = argument[2];
}
else
{
	index = ds_list_size(list) - 1;
}

ds_list_mark_as_list(list, index);