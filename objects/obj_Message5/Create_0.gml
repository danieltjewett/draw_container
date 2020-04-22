#region other vars

menuIndex = 0;

menuList = ds_list_create();

var one = ds_map_create();
one[? "label"] = "Option 1";

var two = ds_map_create();
two[? "label"] = "Option 2";

var three = ds_map_create();
three[? "label"] = "Option 3";

ds_list_add_map(menuList, one);
ds_list_add_map(menuList, two);
ds_list_add_map(menuList, three);

#endregion