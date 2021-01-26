#region draw stuff

var startX = obj_Global.GUI_WIDTH * .5;
var startY = obj_Global.GUI_HEIGHT * .5;

var width = 100;
var height = 25;

var color = c_fuchsia;
var str = string(40);

var container = {
	str: str,
	x: startX,
	y: startY,
	width: width,
	height: height,
	font: font_Arial8,
	fillAlpha: .7,
	fillColor: color,
	textAlpha: 1,
	flow: "split",
	grid: "row",
};

container.children = [];

	array_push(container.children, {
		sprite: spr_arrow,
		imageIndex: 2,
		image_alpha: .7,
		hAnchor: fa_right,
	});
	
	array_push(container.children, {
		sprite: spr_arrow,
		imageIndex: 0,
		image_alpha: .7,
		hAnchor: fa_left,
	});

draw_container(container);

#endregion