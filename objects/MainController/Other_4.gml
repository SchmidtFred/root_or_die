if ( room != RoomGame ) exit;
if ( !tutorial_complete ) {
	coroutine_run(tutorial);	
	tutorial_complete = true;
}