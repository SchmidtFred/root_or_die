function Delegate(context = undefined) constructor{

    sealed_context = ( context == undefined ) ? self : context;
    list = [];
    is_delegate = true;
    
    add     = function(func){
        if ( !is_method(func) ) return;
        array_push(list, func);
    }
    has		= function(func){
    	for ( var i=0; i<array_length(list); i++ ){
    	    if ( list[i] == true ) return true;
    	}
    	return false;
    }
    insert  = function(func){
        if ( !is_method(func) ) return;
        array_insert(list, 0, func);
    }
    remove  = function(func){
        for ( var i=0; i<array_length(list); i++ ){
            if ( list[i] == func ){
                array_delete(list, i, 1);
                break;
            } 
        }
    }
    call    = function(a0=undefined, a1=undefined, a2=undefined, a3=undefined, a4=undefined){
    	var out = undefined;
        var result = undefined;
        for ( var i=0; i<array_length(list); i++){
            var func = list[i];
            with ( sealed_context ){
                result = func(a0, a1, a2, a3, a4);
            }
            if ( result != undefined ) out = result;
        }
        return out;
    }
    clear   = function(){
        list = [];
    }
}
