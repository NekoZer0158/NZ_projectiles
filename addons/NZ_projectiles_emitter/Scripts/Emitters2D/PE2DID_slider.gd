@abstract
@icon("res://addons/NZ_projectiles_emitter/Icons/PE2DID_slider.svg")
class_name PE2DID_slider
extends PE2D_ID

## @experimental
## Recommend to not change position or rotation during runtime. Ignores scale and pivot_offest for now.

@export var autoconnect_drag_ended : bool = true ## Automatically connects drag_ended to _on_slider_drag_ended() (see [PE2DID_Hslider] and [PE2DID_Vslider])
@export_flags("Dragger:1","Slider:2","Ticks:4") var shoot_from : int ## Used when calling emit(). Recommend to not change this value during runtime.
@export var use_default_id_if_no_other_default_id_was_found : bool = false
@export_group("Dragger","dragger_")
@export var dragger_default_id : String
@export var dragger_shoot_direction : ShootDirection ## Will set rotation_degrees for the projectile
@export var dragger_add_vector2 : Vector2
@export_group("Slider","slider_")
@export var slider_default_id : String
@export var slider_shoot_direction : ShootDirectionTwo
@export var slider_add_vector2 : Vector2
@export_group("Ticks","ticks_")
@export var ticks_default_id : String
@export var ticks_shoot_direction : ShootDirectionTwo
@export var ticks_add_vector2 : Vector2

enum SliderThing {DRAGGER,SLIDER,TICKS}
enum ShootDirection {UP,RIGHT,DOWN,LEFT,NO_CHANGE}
enum ShootDirectionTwo {FRONT,BACKWARDS,BOTH,NO_CHANGE}

var _one_step_pixel_size : float
var _dragger_pos : Vector2
var _dragger_rotated_pos : Vector2
var _edge_center_pos : Vector2
var _ticks_positions : Array[Vector2]

const TICK_BOTH_EDGES_SIZE : float = 16
const TICK_EDGE_SIZE : float = 8

func emit(type:int=0) -> void:
	if can_emit:
		if shoot_from & 1:
			emit_dragger(dragger_default_id,type)
		if shoot_from & 2:
			emit_slider(slider_default_id,type)
		if shoot_from & 4:
			emit_ticks(ticks_default_id,type)

func emit_by_id(id:String,type:int=0) -> void:
	if can_emit:
		if shoot_from & 1:
			emit_dragger(id,type)
		if shoot_from & 2:
			emit_slider(id,type)
		if shoot_from & 4:
			emit_ticks(id,type)

func _check_and_instantiate_by_id(id:String,default_id:String,default_id_name:String) -> Projectile:
	var projectile_instance : Projectile
	match getting_method:
		GettingMethod.VARIABLE:
			var dictionary_with_projectiles := node_with_projectiles.get(dictionary_name_with_projectiles_and_ids)
			if dictionary_with_projectiles.has(id):
				projectile_instance = dictionary_with_projectiles[id].instantiate()
			elif dictionary_with_projectiles.has(default_id):
				projectile_instance = dictionary_with_projectiles[default_id].instantiate()
			else:
				if use_default_id_if_no_other_default_id_was_found:
					if dictionary_with_projectiles.has(default_projectile_id):
						projectile_instance = dictionary_with_projectiles[default_projectile_id].instantiate()
					else:
						push_error("There is no default_projectile_id: ",default_projectile_id," in dictionary with projectiles")
				if error_if_there_is_no_id:
					push_error("There is no id: ",id," or ",default_id_name,": ",default_id," in dictionary with projectiles")
				return null
		GettingMethod.FUNCTION:
			projectile_instance = node_with_projectiles.call(function_name,id)
			if projectile_instance == null:
				projectile_instance = node_with_projectiles.call(function_name,default_id)
				if projectile_instance == null and use_default_id_if_no_other_default_id_was_found:
					projectile_instance = node_with_projectiles.call(function_name,default_projectile_id)
	return projectile_instance

func emit_dragger(id:String,type:int=0) -> void:
	if can_emit:
		var projectile_instance : Projectile = _check_and_instantiate_by_id(id,dragger_default_id,"dragger_default_id")
		if projectile_instance != null:
			_set_position_for_projectile(SliderThing.DRAGGER,projectile_instance)
			_set_rotation_for_projectile(SliderThing.DRAGGER,projectile_instance)
			_add_projectile_instance_to_the_scene(projectile_instance,type)

func emit_slider(id:String,type:int=0) -> void:
	if can_emit:
		var projectile_instance : Projectile = _check_and_instantiate_by_id(id,slider_default_id,"slider_default_id")
		if projectile_instance != null:
			_set_position_for_projectile(SliderThing.SLIDER,projectile_instance)
			_set_rotation_for_projectile(SliderThing.SLIDER,projectile_instance)
			_add_projectile_instance_to_the_scene(projectile_instance,type)

func emit_ticks(id:String,type:int=0) -> void:
	if can_emit:
		if !_ticks_positions.is_empty():
			var projectile_instance : Projectile = _check_and_instantiate_by_id(id,ticks_default_id,"ticks_default_id")
			if projectile_instance != null:
				_set_position_for_projectile(SliderThing.TICKS,projectile_instance,randi_range(0,_ticks_positions.size()-1))
				_set_rotation_for_projectile(SliderThing.TICKS,projectile_instance)
				_add_projectile_instance_to_the_scene(projectile_instance,type)
		else:
			push_error("_ticks_positions is empty. Check if tick_count is above 0 in the slider")

func _set_rotation_for_projectile(thing:SliderThing,projectile:Projectile) -> void:
	var _cur_slider : Slider = _get_cur_slider()
	match thing:
		SliderThing.DRAGGER:
			match dragger_shoot_direction:
				ShootDirection.UP:
					projectile.rotation_degrees = -90+_cur_slider.rotation_degrees
				ShootDirection.RIGHT:
					projectile.rotation_degrees = 0+_cur_slider.rotation_degrees
				ShootDirection.DOWN:
					projectile.rotation_degrees = 90+_cur_slider.rotation_degrees
				ShootDirection.LEFT:
					projectile.rotation_degrees = 180+_cur_slider.rotation_degrees
				ShootDirection.NO_CHANGE: # Yes, this is intentional
					pass
		SliderThing.SLIDER:
			match slider_shoot_direction:
				ShootDirectionTwo.FRONT:
					projectile.rotation_degrees = _get_rotation_to_front()+_cur_slider.rotation_degrees
				ShootDirectionTwo.BACKWARDS:
					projectile.rotation_degrees = _get_rotation_to_front()+180+_cur_slider.rotation_degrees
				ShootDirectionTwo.BOTH:
					if randi_range(0,1)==1:
						projectile.rotation_degrees = _get_rotation_to_front()+_cur_slider.rotation_degrees
					else:
						projectile.rotation_degrees = _get_rotation_to_front()+180+_cur_slider.rotation_degrees
				ShootDirection.NO_CHANGE: # Yes, this is intentional
					pass
		SliderThing.TICKS:
			match ticks_shoot_direction:
				ShootDirectionTwo.FRONT:
					projectile.rotation_degrees = _get_rotation_to_front()+_cur_slider.rotation_degrees
				ShootDirectionTwo.BACKWARDS:
					projectile.rotation_degrees = _get_rotation_to_front()+180+_cur_slider.rotation_degrees
				ShootDirectionTwo.BOTH:
					if randi_range(0,1)==1:
						projectile.rotation_degrees = _get_rotation_to_front()+_cur_slider.rotation_degrees
					else:
						projectile.rotation_degrees = _get_rotation_to_front()+180+_cur_slider.rotation_degrees
				ShootDirection.NO_CHANGE: # Yes, this is intentional
					pass

func _set_position_for_projectile(thing:SliderThing,projectile:Projectile,tick_index:int=0) -> void:
	match thing:
		SliderThing.DRAGGER:
			projectile.position = _dragger_rotated_pos+dragger_add_vector2
		SliderThing.SLIDER:
			projectile.position = _get_random_position_from_slider()+slider_add_vector2
		SliderThing.TICKS:
			projectile.position = _ticks_positions[tick_index]+ticks_add_vector2

func _add_projectile_instance_to_the_scene(projectile_instance:Projectile,type:int=0) -> void:
	_set_variables_for_projectile(projectile_instance,type,false)
	_add_projectile_as_child(projectile_instance,false)
	projectile_was_emitted.emit(projectile_instance)

func _calculate_dragger_pos(slider:Slider,cur_slider_is_vslider:bool) -> void:
	if cur_slider_is_vslider:
		_dragger_pos = Vector2(_edge_center_pos.x,_edge_center_pos.y-TICK_EDGE_SIZE-slider.value*_one_step_pixel_size)
	else:
		_dragger_pos = Vector2(_edge_center_pos.x-TICK_EDGE_SIZE-slider.value*_one_step_pixel_size,_edge_center_pos.y)
	_dragger_rotated_pos = (_dragger_pos-slider.global_position).rotated(slider.rotation)+slider.global_position
	if debug:
		print("_dragger_rotated_pos: ",_dragger_rotated_pos)

func _calculate_all_needed_slider_values(slider:Slider) -> void:
	_edge_center_pos = slider.global_position+Vector2(slider.size.x/2,slider.size.y)
	var _calculate_everything_for_this_slider := func(slider_size_float:float,cur_slider_is_vslider:bool) -> void:
		_one_step_pixel_size = (slider_size_float-TICK_BOTH_EDGES_SIZE)/slider.max_value
		_calculate_dragger_pos(slider,cur_slider_is_vslider)
		if slider.tick_count > 0:
			if slider.tick_count > 2 or (slider.ticks_on_borders and slider.tick_count > 1):
				var _tick_distance : float = (slider_size_float-TICK_BOTH_EDGES_SIZE)/(slider.tick_count-1)
				var _tick_min_value : int = 0
				var _tick_max_value : int = slider.tick_count
				if !slider.ticks_on_borders:
					_tick_min_value += 1
					_tick_max_value -= 1
				if debug:
					print("_tick_distance: ",_tick_distance)
					print("_tick_min_value: ",_tick_min_value)
					print("_tick_max_value: ",_tick_max_value)
				for i in range(_tick_min_value,_tick_max_value):
					if cur_slider_is_vslider:
						_ticks_positions.append(Vector2(_edge_center_pos.x,_edge_center_pos.y-TICK_EDGE_SIZE-_tick_distance*i))
					else:
						_ticks_positions.append(Vector2(_edge_center_pos.x-TICK_EDGE_SIZE-_tick_distance*i,_edge_center_pos.y))
	if slider is VSlider:
		_calculate_everything_for_this_slider.call(slider.size.y,true)
	elif slider is HSlider:
		_calculate_everything_for_this_slider.call(slider.size.x,false)
	if debug:
		print("_edge_center_pos: ",_edge_center_pos)
		print("_one_step_pixel_size: ",_one_step_pixel_size)
		print("_dragger_pos: ",_dragger_pos)
		print("_ticks_positions: ",_ticks_positions)
		queue_redraw()

func _draw() -> void:
	if debug:
		draw_circle(_dragger_rotated_pos,9,Color.RED)
		for i in _ticks_positions:
			draw_circle(i-position,7,Color.WHITE)

func _on_slider_drag_ended(value_changed) -> void:
	pass

@abstract
func _get_random_position_from_slider() -> Vector2

@abstract
func _get_cur_slider() -> Slider

@abstract
func _get_rotation_to_front() -> float
