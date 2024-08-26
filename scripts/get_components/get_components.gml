/// @description get_components(str) A function that breaks down a string into components
/// @param str The string (or substring)

// Components are formed by using {{two curly braces around the component.}}
// Single curly braces {} have no effect for components.
// If you have to put two curly braces in the actual string, use a non-rendering character between them.
// Components can be nested within each other. {{This sentence could be gold {{and}} have an italicized 'and'.}}
// To handle {{2|foreign languages}} switching the order of decorators, you can use {{1|tags}} to hard-code the order.
// If no tags are used, the next decorator is used, starting with #1.
// If a tag is invalid, or there aren't enough decorators to accomodate the unlabeled ones, the previous decorator is used.
// This is supposed to be a very resilient system - even if the string is formatted incorrectly, it shouldn't cause a game crash.
// Despite this, unclosed and overlapping curly braces are undefined behavior, and I strongly recommend against them.
// - Hyreon

#macro ADD_CHAR 0              // *
#macro FOUND_DELIMITER_BEGIN 1 // {
#macro FOUND_DELIMITER_END 2   // }
#macro END_TAG 3               // |

function get_components(str)
{
	
	var components = []
	var buffer = ""
	var context_chain = []
	
	var allow_tag = false;
	var components_pushed = 0;
	var brace_depth = 0;
	var last_state = undefined;
	var i = 0;
	while (i < string_length(str))
	{
		var skip = false;
		var char = string_char_at(str,++i);
		
		if (last_state == FOUND_DELIMITER_BEGIN)
		{
			if (char == "{")
			{
				var tags = []
				array_copy(tags,0,context_chain,0,array_length(context_chain));
				array_push(components,{contents: buffer, tags: tags});
				array_push(context_chain,brace_depth + components_pushed);
				buffer = "";
				skip = true;
				brace_depth++;
				allow_tag = true;
			}
			if (!skip) buffer += "{"; //add the previous brace unless skipping both
			last_state = ADD_CHAR;
		}
		else if (last_state == FOUND_DELIMITER_END)
		{
			if (char == "}" && brace_depth > 0)
			{
				brace_depth--;
				allow_tag = false;
				var tags = []
				array_copy(tags,0,context_chain,0,array_length(context_chain));
				array_push(components,{contents: buffer, tags: tags});
				array_pop(context_chain);
				buffer = "";
				skip = true;
				if (brace_depth == 0) components_pushed++
			}
			if (!skip) buffer += "}"; //add the previous brace unless skipping both
			last_state = ADD_CHAR;
		}
		else
		{
			if (char == "{")
			{
				last_state = FOUND_DELIMITER_BEGIN;
				skip = true;
			}
			else if (char == "}")
			{
				last_state = FOUND_DELIMITER_END;
				skip = true;
			}
			else if (char == "|" && allow_tag)
			{
				array_pop(context_chain);
				array_push(context_chain,buffer);
				buffer = "";
				allow_tag = false;
				last_state = END_TAG;
				skip = true;
			}
			else
			{
				last_state = ADD_CHAR;
			}
		}
		
		if (!skip) buffer += char;
	}
	
	if (last_state == FOUND_DELIMITER_BEGIN)
	{
		buffer += "{";
	}
	if (last_state == FOUND_DELIMITER_END)
	{
		buffer += "}";
	}
	
	array_push(components,{contents: buffer, tags: context_chain});
	
	return components;
	
}

function get_contents(component)
{
	return component.contents;
}

function update_data_with_components(data)
{
	data.components = get_components(data.str);
	data.plaintext = string_join_ext("", array_map(data.components, get_contents));
}