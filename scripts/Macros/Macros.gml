#macro SNAKE_SPEED 0.25
#macro DOWN_DIRECTION 270
#macro DIRECTION_ADD 45
#macro ROOT_WIDTH 4
#macro ZOOM_CAMERA_W 320
#macro ZOOM_CAMERA_H 160
#macro BIG_CAM_W 1280
#macro BIG_CAM_H 720

#macro DISPLAY_W display_get_width()
#macro DISPLAY_H display_get_height()
#macro WINDOW_W window_get_width()
#macro WINDOW_H window_get_height()
#macro GUI_W display_get_gui_width()
#macro GUI_H display_get_gui_height()

function null_function(){};
function game_start() { room_goto(RoomGame); }
function show_credits(){ instance_create_layer(0, 0, layer, Credits);};