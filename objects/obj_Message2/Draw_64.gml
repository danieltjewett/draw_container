#region set positioning

var width = 280;

var xx = obj_Global.GUI_WIDTH * .5;
var yy = obj_Global.GUI_HEIGHT * .5;

#endregion
#region draw stuff

var container = {
	x: xx,
	y: yy,
	width: width,
	fillAlpha: .7,
	radius: 5,
	paddingLeft: 20,
	paddingRight: 20,
	paddingTop: 20,
	grid: "column",
};

container.children = [];
	
	array_push(container.children, {
		str: "*Open Inventory*",
		textAlpha: 1,
		shadowAlpha: 1,
		font: font_Arial10,
		marginBottom: 10,
	});
	
	array_push(container.children, {
		str: "Equip weapons, shields, and other gear here.",
		textAlpha: 1,
		shadowAlpha: 1,
		font: font_Arial10,
		marginBottom: 10,
	});
	
	var middleContainer = {
		flow: "split",
	};
	
	middleContainer.children = [];
	
	array_push(container.children, middleContainer);

	var hasContent = false;
	var nextContainer = {
		marginTop: 5,
		flow: "split",
	};
	
	nextContainer.children = [];
	
	//NOTE not adding nextContainer to columns yet until we know we have content

	//sprite
	var length = array_length(sprites); //length of sprites and indexes should be the same

	for (var i=0; i<length; i++)
	{
		var sprite = sprites[i];
		var index = indexes[i];
		var label = labels[i];
	
		var middleData = {
			height: 112,
			sprite: sprite,
			imageXscale: .5,
			imageYscale: .5,
			imageIndex: index,
			imageAlpha: .7,
		};
	
		var nextData = {};
	
		if (!is_undefined(label))
		{
			hasContent = true;
			nextData.str = label;
			nextData.textAlpha = .7;
			nextData.shadowAlpha = .7;
		}
	
		array_push(middleContainer.children, middleData);
		array_push(nextContainer.children, nextData);
	}
	
	if (hasContent)
	{
		array_push(container.children, nextContainer);	
	}
	else
	{
		delete nextContainer; //removes the "children" too	
	}

var button = get_button_label_container("B", 0, .7, .7, 1, c_black, c_white, c_black);
button.vAnchor = fa_top;
array_push(container.children, button);
	
draw_container(container);
delete container;

#endregion