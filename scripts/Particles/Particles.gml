function ParticleClass() constructor {
	
	type	= {};
	system	= part_system_create();
	part_system_automatic_draw(system, false);
	
	static add = function(name){
		type[$ name] = new ParticleType();
		return type[$ name];
	}
	static remove = function(name){
		if ( type[$ name] == undefined ) return;
		type[$ name].destroy();
		variable_struct_remove(type, name);
	}
	static spawn = function(index_or_name, x, y, number){
		var type = is_string(index_or_name) ? type[$ index_or_name] : index_or_name;
		part_particles_create(system, x, y, type.id, number);	
	}
	static destroy = function(){
		var names = variable_struct_get_names(type);
		var i = 0;
		repeat(array_length(names)){
			var name = names[i++];
			type[$ name].destroy();
		}
		type = {};
		part_system_destroy(system);	
	}
	static draw = function(){
		part_system_drawit(system);	
	}
	
}
function ParticleType() constructor {
	id = part_type_create();
	
	static set_life = function(lmin, lmax){
		part_type_life(id, lmin, lmax);
		return self;
	}
	static set_color = function(c1, c2=-1, c3=-1){
		part_type_color3(id, c1, c2=-1 ? c1 : c2, c3=-1 ? c1 : c3);
		return self;
	}
	static set_gravity = function(amt, dir){
		part_type_gravity(id, amt, dir);
		return self;
	}
	static set_direction = function(dmin, dmax, inc){
		part_type_direction(id, dmin, dmax, inc, 0);
		return self;
	}
	static set_speed = function(spd, inc){
		part_type_speed(id, spd, spd, inc, 0);	
		return self;
	}
	static set_sprite = function(sprite, anim, stretch, rand){
		part_type_sprite(id, sprite, anim, stretch, rand);
		return self;
	}
	static set_orientation = function(amin, amax, inc, rel){
		part_type_orientation(id, amin, amax, inc, 0, rel);	
		return self;
	}
	static set_size = function(smin, smax, inc){
		part_type_size(id, smin, smax, inc, false);
		return self;	
	}
	
	static destroy = function(){
		part_type_destroy(id);	
	}
}