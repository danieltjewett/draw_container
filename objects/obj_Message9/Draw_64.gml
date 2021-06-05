//
var data = {
	x: 550,
	y: 50,
	width: 100,
	height: 50,
	fillColor: c_modern_black,
	fillAlpha: .8,
	//padding: 20,
	grid: "row",
	flow: "split",
	children: [
		{
			str: "PIC",
			fillAlpha: .5,
			fillColor: c_red,
			paddingLeft: 20,
			paddingTop: 10,
			paddingRight: 10,
			paddingBottom: 10,
			hAlign: fa_left,
			vAlign: fa_bottom,
		},
		{
			str: "Kar",
			fillAlpha: .5,
			fillColor: c_green,
			marginLeft: 10,
			marginTop: 10,
			marginRight: 10,
			marginBottom: 10,
			hAlign: fa_left,
			vAlign: fa_top,
		}
	]
};

draw_container(data);
//

//
var data = {
	x: 0,
	y: 270,
	hAnchor: fa_left,
	width: 100,
	height: 100,
	fillColor: c_modern_black,
	fillAlpha: .8,
	radius: 20,
	padding: 10,
	grid: "column",
	flow: "split",
	children: [
		{
			str: "PICTURE",
			fillAlpha: .5,
			fillColor: c_red,
			paddingRight: 10,
			paddingBottom: 10,
			hAlign: fa_right,
			vAlign: fa_bottom,
		},
		{
			str: "Karen",
			fillAlpha: .5,
			fillColor: c_green,
			marginRight: 10,
			marginTop: 10,
			hAlign: fa_center,
			vAlign: fa_bottom,
		},
	],
};

draw_container(data);
//

//
var data = {
	name: "data",
	x: 550,
	y: 270,
	width: 120,
	height: 150,
	fillAlpha: .8,
	grid: "column",
	children: [
		{
			name: "col1",
			str: "I am getting so sick of this not working.  My neck is sore and I should go to bed, since I have to work tomorrow.",
			fillAlpha: .5,
			fillColor: c_red,
			padding: 10,
			marginBottom: 10,
			hAlign: fa_right,
			vAlign: fa_bottom,
		},
		{
			name: "col2",
			str: "Bunny",
			fillAlpha: .5,
			fillColor: c_green,
			padding: 10,
			marginTop: 10,
			hAlign: fa_center,
			vAlign: fa_top,
		},
	],
};

draw_container(data);
//

//
var data = {
	str: "SHIELD",
	x: 320,
	y: obj_Global.GUI_HEIGHT,
	vAnchor: fa_bottom,
	width: 50,
	height: 20,
	font: font_Arial8,
	fillAlpha: .8,
};

draw_container(data);
//

//
var data = {
	x: 300,
	y: 0,
	vAnchor: fa_top,
	width: 350,
	height: 50,
	font: font_Arial8,
	fillAlpha: .8,
	flow: "fill",
	grid: "row",
	children: [
		{
			str: "This is so much fun!  I just love it when it works correctly.",
			fillAlpha: .5,
			fillColor: c_red,
			paddingRight: 10,
			marginLeft: 10,
			hAlign: fa_right,
			vAlign: fa_bottom,
		},
		{
			str: "Done",
			fillAlpha: .5,
			fillColor: c_green,
			paddingLeft: 10,
			marginLeft: 10,
			hAlign: fa_center,
			vAlign: fa_top,
		},
	],
};

draw_container(data);
//

//
var data = {
	str: "Target",
	x: 80,
	y: 130,
	width: 90,
	height: 90,
	font: font_Arial8,
	fillAlpha: .8,
	hAlign: fa_right,
	vAlign: fa_top,
	sprite: spr_backdrop,
};

draw_container(data);
//

//
var data = {
	str: "Sword",
	hAnchor: fa_right,
	x: obj_Global.GUI_WIDTH,
	y: 140,
	width: 50,
	height: 50,
	font: font_Arial8,
	fillAlpha: .8,
	radius: -1,
	hAlign: fa_left,
	vAlign: fa_middle,
	padding: 20,
};

draw_container(data);
//

//
var data = {
	str: "Michigan",
	x: 40,
	y: 20,
	textColor: c_black,
	shadowAlpha: .1,
	shadowColor: c_white,
};

draw_container(data);
//

//
var data = {
	str: "Michigan",
	x: 40,
	y: 60,
	sprite: spr_backdrop,
	spriteCover: true,
};

draw_container(data);
//

//
var data = {
	x: obj_Global.GUI_WIDTH * .5,
	y: obj_Global.GUI_HEIGHT * .5,
	width: 260,
	height: 160,
	fillColor: c_modern_black,
	fillAlpha: .8,
	radius: 20,
	padding: 20,
	grid: "row",
	children: [
		{
			str: "PICTURE",
			width: .4,
			fillColor: c_yellow,
			fillAlpha: .5,
		},
		{
			width: .6,
			fillColor: c_yellow,
			fillAlpha: .5,
			marginLeft: 20,
			children: [
				{
					str: "Sword",
					hAlign: fa_center,
					fillColor: c_red,
					fillAlpha: .5,
					height: .15,
				},
				{
					str: "20",
					hAlign: fa_right,
					vAlign: fa_top,
					fillColor: c_green,
					fillAlpha: .5,
					height: .15,
				},
				{
					str: "This is a description of a sword that is really cute and yummy.",
					hAlign: fa_left,
					vAlign: fa_top,
					fillColor: c_blue,
					fillAlpha: .5,
					height: .7,
					marginTop: 10,
				},
			]
		},
	],
};

draw_container(data);
delete data;
//