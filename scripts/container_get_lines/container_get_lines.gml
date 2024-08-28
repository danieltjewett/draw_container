// Breaks the text to be displayed into lines consisting of segments; used to display items correctly when middle-aligned or right-aligned
function container_get_lines(data)
{
	
	//a list of components. actual components are not stored here; instead, a list of segments are.
	//segments contain: a string of text; the line of this string; the width before this; the width after this.
	var lines = [];
	
	var line_index = 0;
	
	var carryover = undefined;
	var carryover_prepend = undefined;
	
	var characters_remaining = data.len;
	var hit_character_limit = false;
	
	var last_width = 0;
	
	for (var i = 0; i < array_length(data.components) && !hit_character_limit;)
	{
		
		var text_to_draw;
		if (is_undefined(carryover))
		{
			text_to_draw = data.components[i].contents;
			if (!is_undefined(carryover_prepend))
			{
				text_to_draw = carryover_prepend + text_to_draw;
				carryover_prepend = undefined;
			}
		}
		else
		{
			text_to_draw = carryover;
			carryover = undefined;
		}
		
		if (string_width(text_to_draw) > data.renderWidth - last_width)
		{
			carryover = "";
			var last_char = "";
			while ((string_width(text_to_draw) > data.renderWidth - last_width || last_char != " ") && string_length(text_to_draw) > 0)
			{
				last_char = string_char_at(text_to_draw, string_length(text_to_draw));
				carryover = last_char + carryover;
				text_to_draw = string_delete(text_to_draw,string_length(text_to_draw),1);
			}
			if (string_length(text_to_draw) == 0)
			{ //if a single word is breaking apart the string display
				if (last_width == 0)
				{ //panic, this segment can't be broken up neatly along a space
					text_to_draw = carryover;
					carryover = "";
					while ((string_width(text_to_draw) > data.renderWidth - last_width) && string_length(text_to_draw) > 0)
					{ //similar process, but no longer picky about splitting up words
						last_char = string_char_at(text_to_draw, string_length(text_to_draw));
						carryover = last_char + carryover;
						text_to_draw = string_delete(text_to_draw,string_length(text_to_draw),1);
					}
					if (string_length(text_to_draw) == 0 && last_width == 0)
					{ //desperation tactic if a string is too small to display correctly
						text_to_draw = carryover;
						carryover = "";
					}
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
		
		if (!is_undefined(carryover))
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
	data.useCache = true;
	
	return lines;
	
}