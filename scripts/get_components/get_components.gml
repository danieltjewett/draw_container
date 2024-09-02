/// @description get_components(str) A function that breaks down a string into components
/// @param str The string (or substring)

// Put asterisks around an item to emphasize it with the chosen color.
// There is no way to escape asterisks. Unmatched asterisks cause a program crash.
// - Hyreon

function get_components(str)
{	
	var components = [];
	var buffer = "";
	var emphasisFlag = false;
	
	var i = 0;
	while (i < string_length(str))
	{
		var char = string_char_at(str,++i);
		
		if (char == "*")
		{
			array_push(components, {
				contents: buffer,
				emphasis: emphasisFlag,
			});
			emphasisFlag = !emphasisFlag;
			buffer = "";
		}
		else
		{
			buffer += char;
		}
	}
	
	array_push(components, {
		contents: buffer,
		emphasis: emphasisFlag,
	});
	
	if (emphasisFlag)
	{
		throw "Unclosed '*'";
	}
	
	return components;
	
}