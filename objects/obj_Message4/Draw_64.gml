#region draw stuff

var xx = obj_Global.GUI_WIDTH * .5;
var yy = obj_Global.GUI_HEIGHT * .25;

var width = 444;

var container = {
	str: "You can't carry any more shields.",
	x: xx,
	y: yy,
	fillAlpha: .7,
	textAlpha: 1,
	width: width,
	padding: 8,
};

draw_container(container);

#endregion