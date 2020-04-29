# Draw Container

![Example](https://github.com/danieltjewett/draw_container/example.png "Example")

A layout text engine for Game Maker Studio 2.  Uses concepts similar to [CSS Layout](https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Introduction) and [Relative Layout](https://developer.android.com/guide/topics/ui/layout/relative).

## Example Project

The project has a few examples to get us started using the `draw_container` script.  Simply run the game to see them in action.  Use the arrow keys to view the available examples.  Press `ESC` to end the game.

## Installation

This project requires Game Maker Studio 2, which can be downloaded at https://www.yoyogames.com/gamemaker .  Once GMS2 is installed, we can open this project by downloading the latest zip here: https://github.com/danieltjewett/draw_container/releases .  To get this working in our own project, simply follow these steps:

1. Copy the required scripts, `draw_container`, `container_get_width`, `container_get_height`, `container_get_width_percent`, `container_get_height_percent`, `magnitude`, `draw_reset_font_and_color` to our game.
2. If we have a `macros` script in our project already, add `#macro c_modern_black 789516` to the file.  Otherwise, copy `macros` script over as well.
3. Copy `font_Arial8` to our game.

To use, simply call `draw_container(data)`.  A list of the available properties are below.

## Documentation

`data` - a `ds_map` with the following properties:

* `xx` - defaults to `0`.  The x position of the container.  Note, a child with `xx` property will move itself relative to the left or right.  This DOES NOT effect the layout / positioning of other siblings.
* `yy` - defaults to `0`.  The y position of the container.  Note, a child with `yy` property will move itself relative to the up or down.  This DOES NOT effect the layout / positioning of other siblings.
* `grid` - required for root container with children.  Available options are `column` or `row`.  If this option is not specified in children containers that have children, and `grid` is not specified, the `grid` option will alternate.  The option `column` will layout the children by stacking them.  The option `row` will layout the children by placing the children next to each other.
* `flow` - defaults to `fill`.  Available options are `fill` or `split`.  When a container is set to `fill`, if no sizes are specified for a child, the child will only compute a size necessary for itself, with the exception of the last child, which will "fill" the remainder width if `grid` is set to `row`, or "fill" the remainder height if `grid` is set to `column`.  The other option `split` will split the children sizes evenly based on the number of children.  If `grid` is set to `row`, all the widths will be equal in size.  If `grid` is set to `column`, all the heights will be equal in size.
* `margin` - defaults to `0`.  The spacing between other siblings.  Individual margins can be controlled with `marginLeft`, `marginTop`, `marginRight`, and `marginBottom`.  Setting a margin at the root container will cause an error, since there is no reason for margin at the root.
* `padding` - defaults to `0`.  The spacing between the "content" and the margin.  Individual padding can be controlled with `paddingLeft`, `paddingTop`, `paddingRight`, and `paddingBottom`.
* `width` - the width of the "content" (not including `marginLeft`, `marginRight`, `paddingLeft`, `paddingRight`).  If no width is specified, rules of flow will be applied.  Widths > 0 and <= 1 will calculate itself based on a percentage of the parent width and `marginLeft`, `marginRight`, `paddingLeft`, `paddingRight` will be subtracted after width has been computed.  If the text content is larger than the width, line wrapping will automatically be applied.
* `height` - the height of the "content" (not including `marginTop`, `marginBottom`, `paddingTop`, `paddingBottom`).  If no height is specified, rules of flow will be applied.  Heights > 0 and <= 1 will calulcate itself based on a perentage of the parent height and `marginTop`, `marginBottom`, `paddingTop`, `paddingBottom` will be subtracted after height has been computed.  If the text content is larger than the height, the text will overflow.
* `str` - defaults to `""`.  The "content", or the actual text we want to draw.
* `font` - defaults to `font_Arial8`.  The font we want to render our `str` with.
* `lineHeight` - defaults to `-1`.  The spacing between lines of the content.  See `sep` argument at https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/strings/string_height_ext.html
* `hAnchor` - defaults to `fa_center`.  Anchors the container on a horizontal side.  `fa_center` won't do anything, where `fa_left` will anchor content on the left, while `fa_right` will anchor content on the right.
* `vAnchor` - defaults to `fa_middle`.  Anchors the container on a vertical side.  `fa_middle` won't do anything, where `fa_top` will anchor content to the top, while `fa_bottom` will anchor content to the bottom.
* `hAlign` - defaults to `fa_center`.  Aligns the content horizontally.  `fa_center` will center the text.  `fa_left` will align the text to the left.  `fa_right` will align the text to the right.
* `vAlign` - defaults to `fa_middle`.  Aligns the content vertically.  `fa_middle` will center the text.  `fa_top` will align the text to the top.  `fa_bottom` will align the text to the bottom.
* `sprite` - defaults to `""` (which means not used).  A background sprite to be drawn.
* `imageIndex` - defaults to `0`.  The image index of the background sprite to be drawn at.  Ignored if no sprite is specified.
* `imageRotation` - defaults to `0`.  The image angle of the background sprite to be drawn at.  Ignored if no sprite is specified.
* `imageColor` - defaults to `-1` (which means no blending).  The image color of the background sprite to be drawn at.  Ignored if no sprite is specified.
* `imageAlpha` - defaults to `1`.  The image alpha of the background sprite to be drawn at.  Ignored if no sprite is specified.
* `spriteCover` - defaults to `false`.  If `true`, the sprite will cover the entire width / height of the container.
* `imageXscale` - defaults to `1`.  The image xscale of the background sprite to be drawn at.  Ignored if no sprite is specified.  If `spriteCover` is set, this property should be ignored, otherwise an error will be thrown.
* `imageYscale` - defaults to `1`.  The image yscale of the background sprite to be drawn at.  Ignored if no sprite is specified.  If `spriteCover` is set, this property should be ignored, otherwise an error will be thrown.
* `fillColor` - defaults to `c_modern_black`.  The background color of the container to be used.
* `fillAlpha` - defaults to `0`.  The alpha of the background to be used.
* `radius` - defaults to `0`.  The radius of the background color.  If `-1` is used, the radius will be automatically calculated based on the size of the container.
* `textColor` - defaults to `c_white`.  The color to draw the text with.
* `textAlpha` - defaults to `1`.  The alpha to draw the text color at.
* `shadowColor` - defaults to `c_black`.  The shadow color to draw the text with.
* `shadowAlpha` - defaults to the value of `textAlpha`.  The alpha to draw the shadow color at.
* `borderColor` - defaults to `c_white`.  The color to draw a border with.
* `borderAlpha` - defaults to `0`.  The alpha to draw the borderColor at.
* `children` - a `ds_list` of `ds_maps` representing the children containers
  
###### INTERNAL PROPERTIES
  
* `parent` - pointer to the parent container.
* `widthPercent` - the width of the container as a percentage.
* `heightPercent` - the height of the container as a percentage.
* `strWidth` - See https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/strings/string_width.html for more details.  Used in computing the width of a container.
* `strHeight` - Used in computing the height of a container.  Takes into account the width of a container.
* `computedWidth` - Without overriding the width property, computes the width of a container based on its children, grid type, `marginLeft`, `marginRight`, `paddingLeft`, `paddingRight`, `strWidth`.
* `computedHeight` - Without overriding the height property, computes the height of a container based on its children, grid type, `marginTop`, `marginBottom`, `paddingTop`, `paddingBottom`, `strHeight`.
* `_calculated` - whether the current container has been fully calculated with the correct widths / heights.

##### Notes

* `data` automatically gets cleaned up after the `draw_container` call.
* The `calculateOnly` argument is for internal use only.  Don't invoke `draw_container` with the second argument.  Simply use `draw_container(data)`

## Contributing

Thank you for considering contributing to Draw Container! To encourage active collaboration, we encourage pull requests, not just issues.

If you file an issue, the issue should contain a title and a clear description of the issue. You should also include as much relevant information as possible and a code sample that demonstrates the issue. The goal of a issue is to make it easy for yourself - and others - to replicate the bug and develop a fix.

## License

GMS Tasks is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT).