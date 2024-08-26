/// @description get_components(str) A function that breaks down a string into components
/// @param str The string (or substring)

// Components are formed by using {{two curly braces around the component.}}
// Single curly braces {} have no effect for components.
// If you have to put two curly braces in the actual string, use a non-rendering character between them.
// Components can be nested within each other. {{This sentence could be gold {{and}} have an italicized 'and'.}}
// To handle {{2|foreign languages}} switching the order of emphasized text, you can use {{1|tags}} to hard-code the order.
// If no tags are used, the next decorator is used, starting with #1.
// This is supposed to be a very resilient system - even if the string is formatted incorrectly, it shouldn't cause a game crash.
// Despite this, unclosed and overlapping curly braces are undefined behavior, and I strongly recommend against them.
// - Hyreon

function get_components(str)
{
	//var components = [{contents: str, emphasis: false}];
	//return components;
	
	var components = [];
	var buffer = "";
	var emphasisFlag = false;
	
	var i = 0;
	while (i < string_length(str))
	{
		var skip = false;
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