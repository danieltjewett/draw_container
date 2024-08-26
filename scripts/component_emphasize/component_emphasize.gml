// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function component_emphasize(str, substr = "", tag = -1)
{
	
	if (substr == "")
	{
		substr = str;
	}
	
	var last_pos = 0;
	while (true)
	{
		var pos = string_pos_ext(substr,str,last_pos);
		if (pos == 0) break;
		last_pos = pos + string_length(substr) + 2;
		str = string_insert("*",str,pos + string_length(substr));
		str = string_insert("*",str,pos);
	}
	
	return str;
	
}