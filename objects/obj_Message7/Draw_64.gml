#region draw stuff

var xx = obj_Global.GUI_WIDTH * .5;
var yy = obj_Global.GUI_HEIGHT - 100;

var text = currentMessage;
var index = floor(clamp(characterCounter, 0, currentMessageLength));
var printText = string_copy(text, 1, index);
	
var textBoxWidth = 500;
var textBoxHeight = 100;

//
var container = {
	x: xx,
	y: yy,
	width: textBoxWidth,
	grid: "column",
};

container.children = [];

	var wrapper = {
		height: textBoxHeight,
		radius: -1,
		fillAlpha: .7,
	};

	array_push(container.children, wrapper);
	
	wrapper.children = [];

		array_push(wrapper.children, {
			y: -14,
			width: 2,
			sprite: messagePortrait,
			imageAlpha: 1,
		});

		var messageContainer = {
			y: -7,
			marginLeft: 50,
		};
		
		array_push(wrapper.children, messageContainer);
		
		messageContainer.children = [];
		
			var titleContainer = {};
			titleContainer.children = [];

				var titleData = {
					str: messageTitle,
					textAlpha: 1,
					font: font_Arial10,
					hAlign: fa_left,
					sprite: spr_backdrop,
					spriteCover: true,
					imageAlpha: .7,
				};

				var titleFiller = {};

				array_push(titleContainer.children, titleData);
				array_push(titleContainer.children, titleFiller);

			array_push(messageContainer.children, titleContainer);
		
			var messageData = {
				str: printText,
				y: 8,
				paddingTop: 10,
				paddingRight: 20,
				paddingBottom: 8,
				textAlpha: 1,
				font: font_Arial12,
				hAlign: fa_left,
				vAlign: fa_top,
			}
		
			array_push(messageContainer.children, messageData);
	
	var sizeScale = 1;
	var spriteAlpha = 0;
	var textAlpha = 0;
	var textColor = c_white;
	var shadowColor = c_black;
	var color = c_black;
	if (characterCounter >= currentMessageLength)
	{
		spriteAlpha = .7;
		textAlpha = 1;
		if (messageIndex + 1 < messageLength)
		{
			textColor = c_black;
			shadowColor = c_white;
			color = -1;
		}
	}
	
	var button = get_button_label_container("B", 0, spriteAlpha, textAlpha, sizeScale, color, textColor, shadowColor);
	button.vAnchor = fa_bottom;
	array_push(container.children, button);

draw_container(container);
//

characterCounter += characterCounterSpeed;

#endregion