// Breaks the text to be displayed into lines consisting of segments; used to display items correctly when middle-aligned or right-aligned
function container_get_lines(data, get_blank_lines = true)
{
	
	//a list of components. actual components are not stored here; instead, a list of segments are.
	//segments contain: a string of text; the line of this string; the width before this; the width after this.
	var lines = [];
	
	var line_index = 0;
	
	var carryover = undefined; //text to put onto the next line by calculation
	var carryover_prepend = undefined; //text to put at the beginning of the next segment (whitespace)
	var forced_to_newline = undefined; //text immediately after a \n character
	
	var characters_remaining = data.len; //limit on how many characters can be drawn at once
	var hit_character_limit = false;
	
	var last_width = 0;
	
	var numComponents = array_length(data.components)
	for (var i = 0; i < numComponents && (get_blank_lines || !hit_character_limit);)
	{
		
		var text_to_draw;
		if (is_undefined(carryover)) //If this is the start of a new component, try to print all of its contents
		{
			if (!is_undefined(forced_to_newline))
			{
				text_to_draw = forced_to_newline;
				forced_to_newline = undefined;
				if (!get_blank_lines) characters_remaining--;
			}
			else
			{
				text_to_draw = data.components[i].contents;
				if (!is_undefined(carryover_prepend))
				{
					text_to_draw = carryover_prepend + text_to_draw;
					carryover_prepend = undefined;
				}
			}
			
			if (string_pos("\n", text_to_draw) != 0)
			{
				var split_text = string_split(text_to_draw,"\n",false,1)
				text_to_draw = split_text[0];
				forced_to_newline = split_text[1];
			}
		}
		else //If a previous component wasn't able to draw all of its components, try to print all that remains
		{
			text_to_draw = carryover;
			carryover = undefined;
		}
		
		if (string_width(text_to_draw) > data.renderWidth - last_width)
		{
			carryover = "";
			var last_char = "";
			while ((string_width(text_to_draw) > data.renderWidth - last_width || last_char != " ") && string_length(text_to_draw) > 0)
			{ //break up the component into a smaller segment, character by character, until a space is reached
				last_char = string_char_at(text_to_draw, string_length(text_to_draw));
				carryover = last_char + carryover;
				text_to_draw = string_delete(text_to_draw,string_length(text_to_draw),1);
			}
			if (string_length(text_to_draw) == 0 && last_width == 0)
			{ //if a single, long word is breaking apart the string display ('He believes in / Antidisestablishmentarianism', with enough room for only 20 characters)
				text_to_draw = carryover;
				carryover = "";
				while ((string_width(text_to_draw) > data.renderWidth - last_width) && string_length(text_to_draw) > 0)
				{ //similar process, but split the word in half, rather than neatly at the beginning or end of a word
					last_char = string_char_at(text_to_draw, string_length(text_to_draw));
					carryover = last_char + carryover;
					text_to_draw = string_delete(text_to_draw,string_length(text_to_draw),1);
				}
				if (string_length(text_to_draw) == 0)
				{ //if a single character is still bleeding over the width, just render the whole string as a single line; nothing is going to work
					text_to_draw = carryover;
					carryover = "";
				}
			}
			carryover = string_trim_start(carryover);
		}
		
		//move whitespace to the next component, so that it can decide whether to keep it or not
		if (string_ends_with(text_to_draw, " "))
		{
			carryover_prepend = "";
			while (string_ends_with(text_to_draw, " "))
			{
				carryover_prepend += " ";
				text_to_draw = string_delete(text_to_draw,string_length(text_to_draw),1);
			}
		}
		
		if (string_length(text_to_draw) > characters_remaining)
		{
			text_to_draw = string_copy(text_to_draw,0,characters_remaining);
			characters_remaining = 0;
		}
		else
		{
			characters_remaining -= string_length(text_to_draw);
		}
		if (characters_remaining <= 0) hit_character_limit = true;
		
		while (array_length(lines) <= line_index)
		{
			array_push(lines, {
				width: 0,
				segments: []
			});
		}
		
		last_width += string_width(text_to_draw);
		
		var line = lines[line_index];
		//show_debug_message(lines);
		array_push(line.segments, {
			contents: text_to_draw,
			emphasis: data.components[i].emphasis,
			remaining: carryover
		});
		
		if (!is_undefined(carryover) || !is_undefined(forced_to_newline))
		{ // includes blank carryover, for when a new component is also a new line, but a space separates them
			lines[line_index].width = last_width;
			line_index++;
			last_width = 0;
		}
		else
		{
			i++;	
		}
		
	}
	
	if (line_index < array_length(lines))
	{
		lines[line_index].width = last_width;
	}
	
	data.segments = lines;
	
	return lines;
	
}