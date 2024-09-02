/// @description log([str1, ...])
/// @param str1
/// @param ...
function log()
{
	var str = "";

	for (var i=0; i<argument_count; i++)
	{
		str += string(argument[i]) + " ";
	}

	show_debug_message(str);
}