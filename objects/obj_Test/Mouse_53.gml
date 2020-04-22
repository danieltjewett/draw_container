if (state == 0 || state == 2)
{
	px1 = window_mouse_get_x() / SCREEN_WIDTH;
	py1 = window_mouse_get_y() / SCREEN_HEIGHT;
	
	state = 1;
}
else if (state == 1)
{
	px2 = window_mouse_get_x() / SCREEN_WIDTH;
	py2 = window_mouse_get_y() / SCREEN_HEIGHT;
	
	state = 2;
}