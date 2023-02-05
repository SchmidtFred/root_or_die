// Internal
enum e_coroutine 		{ finished, running, complete, updating };
#macro co_Begin			if (CoroutineID.__pos == __pos++) && global.__coroutineUpdater.is_enabled
#macro co_End			CoroutineID.__pos = __pos; return;}

// Completion
#macro End				} CoroutineID.__end();
#macro Loop				CoroutineID.__pos = 0;}

// Utilities
#macro CoroutineID		argument[0]
#macro Start			var __pos=0; CoroutineID.__status = e_coroutine.running; co_Begin
#macro Then				co_End co_Begin(){
#macro Step				{CoroutineID.__status = e_coroutine.updating; return;} Then
#macro Quit				Escape(undefined)
#macro Goto				CoroutineID.__goto
#macro Escape			CoroutineID.__end
#macro Await			CoroutineID.__await
#macro Yield			CoroutineID.__wait =
#macro Coroutine		function(){ Start
#macro Region			co_End if ( CoroutineID.__pos == 
#macro Endregion		){ CoroutineID.__pos = __pos; } co_Begin(){

function __coroutineRunner() constructor {
	list = new Delegate(self);
	tick = undefined;
	enabled = true;
	
	update = function(){
		list.call();
	}
	add = function(f){ list.add(f); }
	remove = function(f){ list.remove(f); }
	destroy = function(){ time_source_destroy(tick); }
	pause = function(paused){
		enabled = !paused;
		if ( paused ) time_source_pause(tick);
		else time_source_start(tick);
	}
	enable = function(on=true){
		pause(!on);
	}
	is_enabled = function(){
		return enabled;
	}
	
	tick = time_source_create(time_source_game, 1, time_source_units_frames, update, [], -1);
	enable();
}
global.__coroutineUpdater = new __coroutineRunner();
function __coroutine() constructor {
    
	__pos = 0; 
	__loop = 0;
	__status = e_coroutine.finished;
	__wait = 0;
	__return = undefined;
	__func = undefined;
	__paused = true;
	__on_update = new Delegate(self);
	__on_return = new Delegate(self);
	
	global.__coroutineUpdater.add(function(){__on_update.call();});
	
	__main_update=function()/*=>*/{
		repeat(100){
			if ( __paused ) return;
			if ( __wait > 0 ) { __wait--; return; }
			__func(self);
			
			switch(__status){
				case e_coroutine.finished: __end(); return;
				case e_coroutine.complete: return;
				case e_coroutine.updating: __status = e_coroutine.running; return;
			}
		}
	}
	__pause=function()/*=>*/{ __paused = true; __on_update.remove(__main_update); }
	__play=function()/*=>*/{
		if ( __paused && !__on_update.has(__main_update)){
			__on_update.add(__main_update);
		}
		__paused = false;
		return self;
	}
	static __await=function(scr)/*=>*/{
		if ( is_method(scr)) scr = coroutine_run(scr);
		else if ( instanceof(scr) == "struct" ){
			var fn = scr[$ "__func"];
			scr = coroutine_run(fn, scr);
		}
		__pause();
		scr.__on_return.add(__play);
		return scr;
	}
	static __destroy=function()/*=>*/{
		__on_update.clear();
		global.__coroutineUpdater.remove(__on_update);
	}
	static __goto=function(region)/*=>*/{ __pos = region;
	}
	static __end=function(arg=undefined)/*=>*/{
		if ( arg != undefined ) __return = arg;
		__status = e_coroutine.complete;
		__on_return.call(arg);
		__destroy();
	}
	static __init=function()/*=>*/{
	    for ( var i=0; i<argument_count; i++ ){
	        var arg = argument[i];
	        var name= variable_struct_get_names(arg);
	        for ( var j=0; j<array_length(name); j++ ){
	            self[$ name[j]] = arg[$ name[j]];
	        }
	    }
	}
	__play();
}
function coroutine_await_value(cvalue){
	return cvalue.__return;
}
function coroutine_run(co_rout, data={}, subdata={}){
    var new_corout = new __coroutine();
    
    subdata.__func = co_rout;
    new_corout.__init(data, subdata);
	return new_corout;
}

