#region set positioning

var halfScreenWidth = obj_Global.GUI_WIDTH * .5;
var halfScreenHeight = obj_Global.GUI_HEIGHT * .5;

var bottomScreenHeight = obj_Global.GUI_HEIGHT * .9;

var xx = halfScreenWidth;
var yy = halfScreenHeight;

#endregion
#region draw stuff

var str = "Game Over";

var str1 = "Press Start to Continue";

var str2 = component_emphasize("Battle {{0|Tip}}:  Taking on enemies that are too {{0|tough}} is a good sign that it is too soon to explore an area.", "too", 1);

var container = {
	x: xx,
	y: yy,
	width: obj_Global.GUI_WIDTH,
	height: obj_Global.GUI_HEIGHT,
	fillAlpha: 1,
	flow: "split",
	grid: "column",
	children: [
		{
			height: .45,
		},
		{
			str: str,
			height: .1,
			font: font_Arial16,
			textColor: c_red,
			textAlpha: 1,
			shadowAlpha: 1,
		},
		{
			str: str1,
			height: .2,
			font: font_Arial10,
			textAlpha: 1,
			shadowAlpha: 1,
		},
		{
			height: .05,
		},
		{
			str: str2,
			width: .65,
			height: .2,
			font: font_Arial10,
			textAlpha: 1,
			shadowAlpha: 1,
			emphasisColor: c_fuchsia
		}
	]
};

draw_container(container);
delete container;

#endregion