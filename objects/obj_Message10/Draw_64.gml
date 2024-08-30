#region draw stuff

_image_alpha = clamp(_image_alpha + .02, 0, 1);

container.width = -1;
container.fillAlpha = _image_alpha * _alphaMulti;
container.textAlpha = _image_alpha;
container.shadowAlpha = _image_alpha;
container.len++;

draw_container(container);

#endregion