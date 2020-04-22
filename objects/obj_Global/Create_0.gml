//screen and camera consts
#region consts

SCREEN_WIDTH = display_get_width();
SCREEN_HEIGHT = display_get_height();

GAME_WIDTH = 640;
GAME_HEIGHT = 360;

GUI_WIDTH = GAME_WIDTH;
GUI_HEIGHT = GAME_HEIGHT;

#endregion
#region initialize window

surface_resize(application_surface, GAME_WIDTH, GAME_HEIGHT);
window_set_size(SCREEN_WIDTH, SCREEN_HEIGHT);
alarm[0] = 1;

#endregion
#region initialize gui

display_set_gui_size(GUI_WIDTH, GUI_HEIGHT);

#endregion