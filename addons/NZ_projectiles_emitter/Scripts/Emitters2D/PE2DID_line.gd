@icon("res://addons/NZ_projectiles_emitter/Icons/PE2DID_line.svg")
class_name PE2DID_line
extends PE2D_ID

## @experimental

@export var lines : Array[Line2D]
@export var rotate_projectile_perpendicular : bool = true
@export var look_reverse : bool = true

enum {NEW_POSITION,FIRST_POINT,SECOND_POINT}

func _ready() -> void:
	if lines.is_empty():
		push_error("lines is empty, there should be at least one Line2D")
	super()

func _add_projectile_instance_to_the_scene(projectile_instance:Projectile,type:int=0) -> void:
	_set_variables_for_projectile(projectile_instance,type)
	var cur_line := lines.pick_random()
	var pos_and_points : Array= _get_random_position_in_line_and_points(lines.pick_random(),look_reverse,debug)
	projectile_instance.position = pos_and_points[NEW_POSITION]
	if rotate_projectile_perpendicular:
		projectile_instance.rotation = pos_and_points[FIRST_POINT].angle_to_point(pos_and_points[SECOND_POINT])-deg_to_rad(90)
	if is_instance_valid(add_child_to_this_node):
		add_child_to_this_node.call_deferred("add_child",projectile_instance)
	else:
		add_child(projectile_instance)

static func _get_random_position_in_line_and_points(line:Line2D,look_reverse_local:bool=false,debug_local:bool=false) -> Array:
	if line.points.size() >= 2:
		var points_size : int = line.points.size()-1
		var min_point_index : int = 0
		if !line.closed:
			if look_reverse_local:
				points_size -= 1
			else:
				min_point_index += 1
		var first_point_index : int = randi_range(min_point_index,points_size)
		var first_point : Vector2 = line.points.get(first_point_index)
		var second_point : Vector2
		if first_point_index == line.points.size()-1 and line.closed:
			if look_reverse_local:
				second_point = line.points.get(0)
			else:
				second_point = line.points.get(first_point_index-1)
		elif first_point_index == 0 and line.closed:
			if look_reverse_local:
				second_point = line.points.get(first_point_index+1)
			else:
				second_point = line.points.get(points_size)
		else:
			if look_reverse_local:
				second_point = line.points.get(first_point_index+1)
			else:
				second_point = line.points.get(first_point_index-1)
			#second_point = line.points.get(first_point_index+[-1,1].pick_random())
		var random_vec := line.position+first_point.move_toward(second_point,randf_range(0,first_point.distance_to(second_point)))
		if debug_local:
			print(random_vec)
		return [random_vec,first_point,second_point]
	push_error("Not enough points in line")
	return [Vector2.ZERO,Vector2.ZERO,Vector2.ZERO]
