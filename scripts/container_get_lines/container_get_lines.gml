/// @description container_get_lines(data) Breaks the text to be displayed into lines consisting of segments; used to display items correctly when middle-aligned or right-aligned
/// @param data
function container_get_lines(data)
{
	#region parse for * and get the components
	
	var components = [];
	var buffer = "";
	var emphasisFlag = false;
	
	var strLength = string_length(data.str);
	for (var i=1; i<=strLength; i++)
	{
		var char = string_char_at(data.str, i);
		
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
	
	if (emphasisFlag)
	{
		throw "Unclosed '*'";
	}
	
	array_push(components, {
		contents: buffer,
		emphasis: emphasisFlag,
	});
	
	#endregion
	#region get the lines
	
	//clean up lines, if they already exist
	if (variable_struct_exists(data, "lines"))
	{
		delete data.lines;
	}
	
	//a list of components. actual components are not stored here; instead, a list of segments are.
	//segments contain: a string of text; the line of this string; the width before this; the width after this.
	data.lines = [];
	
	var lineIndex = 0;
	
	var carryover = undefined; //text to put onto the next line by calculation
	var carryoverPrepend = undefined; //text to put at the beginning of the next segment (whitespace)
	var forcedToNewline = undefined; //text immediately after a \n character
	
	var charactersRemaining = data.typewriterLength == undefined ? string_length(data.str) : data.typewriterLength; //limit on how many characters can be drawn at once
	var hitCharacterLimit = false;
	
	var lastWidth = 0;
	
	var numComponents = array_length(components)
	for (var i=0; i<numComponents && !hitCharacterLimit;)
	{
		var textToDraw;
		if (is_undefined(carryover)) //If this is the start of a new component, try to print all of its contents
		{
			if (!is_undefined(forcedToNewline))
			{
				textToDraw = forcedToNewline;
				forcedToNewline = undefined;
			}
			else
			{
				textToDraw = components[i].contents;
				if (!is_undefined(carryoverPrepend))
				{
					textToDraw = carryoverPrepend + textToDraw;
					carryoverPrepend = undefined;
				}
			}
			
			if (string_pos("\n", textToDraw) != 0)
			{
				var splitText = string_split(textToDraw, "\n", false, 1);
				textToDraw = splitText[0];
				forcedToNewline = splitText[1];
				delete splitText;
			}
		}
		else //if a previous component wasn't able to draw all of its components, try to print all that remains
		{
			textToDraw = carryover;
			carryover = undefined;
		}
		
		var strLength = string_length(textToDraw);
		var textToDrawWidth = string_width(textToDraw);
		if (textToDrawWidth > data.renderWidth - lastWidth)
		{
			carryover = "";
			var lastChar = "";
			
			//break up the component into a smaller segment, character by character, until a space is reached
			while ((textToDrawWidth > data.renderWidth - lastWidth || lastChar != " ") && strLength > 0)
			{ 
				lastChar = string_char_at(textToDraw, strLength);
				carryover = lastChar + carryover;
				textToDraw = string_delete(textToDraw, strLength, 1);
				textToDrawWidth = string_width(textToDraw);
				strLength --;
			}
			
			//if a single, long word is breaking apart the string display ('He believes in / Antidisestablishmentarianism', with enough room for only 20 characters)
			if (strLength == 0 && lastWidth == 0)
			{
				textToDraw = carryover;
				carryover = "";
				
				textToDrawWidth = string_width(textToDraw);
				strLength = string_length(textToDraw);
				
				//similar process, but split the word in half, rather than neatly at the beginning or end of a word
				while ((textToDrawWidth > data.renderWidth - lastWidth) && strLength > 0)
				{
					lastChar = string_char_at(textToDraw, strLength);
					carryover = lastChar + carryover;
					textToDraw = string_delete(textToDraw, strLength, 1);
					textToDrawWidth = string_width(textToDraw);
					strLength --;
				}
				
				//if a single character is still bleeding over the width, just render the whole string as a single line; nothing is going to work
				if (strLength == 0)
				{ 
					textToDraw = carryover;
					carryover = "";
				}
			}
			carryover = string_trim_start(carryover);
		}
		
		//move whitespace to the next component, so that it can decide whether to keep it or not
		if (string_ends_with(textToDraw, " "))
		{
			carryoverPrepend = "";
			while (string_ends_with(textToDraw, " "))
			{
				carryoverPrepend += " ";
				textToDraw = string_delete(textToDraw, strLength, 1);
				strLength --;
			}
			textToDrawWidth = string_width(textToDraw);
		}
		
		if (strLength > charactersRemaining)
		{
			textToDraw = string_copy(textToDraw, 0, charactersRemaining);
			textToDrawWidth = string_width(textToDraw);
			charactersRemaining = 0;
		}
		else
		{
			charactersRemaining -= strLength;
		}
		
		if (charactersRemaining <= 0)
		{
			hitCharacterLimit = true;
		}
		
		while (array_length(data.lines) <= lineIndex)
		{
			array_push(data.lines, {
				width: 0,
				segments: [],
			});
		}
		
		lastWidth += textToDrawWidth;
		
		var line = data.lines[lineIndex];
		array_push(line.segments, {
			contents: textToDraw,
			emphasis: components[i].emphasis,
			remaining: carryover,
			width: textToDrawWidth,
		});
		
		//includes blank carryover, for when a new component is also a new line, but a space separates them
		if (!is_undefined(carryover) || !is_undefined(forcedToNewline))
		{
			data.lines[lineIndex].width = lastWidth;
			lineIndex++;
			lastWidth = 0;
		}
		else
		{
			i++;	
		}
	}
	
	if (lineIndex < array_length(data.lines))
	{
		data.lines[lineIndex].width = lastWidth;
	}
	
	delete components;
	
	#endregion
}