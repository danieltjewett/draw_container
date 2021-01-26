#region draw stuff

var width = 130;

var xx = obj_Global.GUI_WIDTH;
var yy = 60;

var container = {
	str: "This is an example of a message that could be used for a tip.",
	x: xx,
	y: yy,
	hAnchor: fa_right,
	vAnchor: fa_top,
	font: font_Arial8,
	hAlign: fa_left,
	fillAlpha: .7,
	textAlpha: 1,
	width: width,
	paddingTop: 10,
	paddingBottom: 10,
	paddingLeft: 15,
	paddingRight: 15,
};

draw_container(container);

#endregion