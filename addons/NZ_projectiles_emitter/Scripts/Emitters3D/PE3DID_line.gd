@icon("res://addons/NZ_projectiles_emitter/Icons/PE3DID_line.svg")
class_name PE3DID_line
extends PE3D_ID

## Set centered in [color=mediumturquoise]Sprite3D[/color] to [color=red]false[/color], otherwise it will not work as intented [br]
## [color=cyan]Can be changed and it will work[/color]: flip_h, flip_v, pixel_size, position, scale  [br]
## [color=red]Don't change[/color] rotation in [color=mediumturquoise]Sprite3D[/color] (will be added later)
## @experimental

## The size should be the same as lines2D;[br][color=mediumturquoise]Line2D[/color] and [color=mediumturquoise]Sprite3D[/color] with the same index should relate to each other (sprite should show this exact line)
@export var sprites3D : Array[Sprite3D]
## The size should be the same as sprites3D;[br][color=mediumturquoise]Line2D[/color] and [color=mediumturquoise]Sprite3D[/color] with the same index should relate to each other (sprite should show this exact line)
@export var lines2D : Array[Line2D]

## Will use this node rotation for every projectile
@export var node_rotation : Node3D:
	set(value):
		if value != null and node_rotation != value:
			value.tree_exited.connect(_set_node_rotation_to_null)
		node_rotation = value

func _ready() -> void:
	if lines2D.is_empty():
		push_error("lines2D is empty, there should be at least one Line2D")
	if sprites3D.is_empty():
		push_error("sprites3D is empty, there should be at least one Sprite3D")
	if sprites3D.size() != lines2D.size():
		push_error("sprites3D size should be the same as lines2D size")
	super()

func _set_node_rotation_to_null() -> void:
	node_rotation = null

func _add_projectile_instance_to_the_scene(projectile_instance:Projectile3D,type:int=0) -> void: # TODO
	_set_variables_for_projectile(projectile_instance,type)
	var cur_index := randi_range(0,sprites3D.size()-1)
	var pos_and_points : Array = PE2DID_line._get_random_position_in_line_and_points(lines2D[cur_index],false,debug)
	var pos3D := _get_pos_in_3D(pos_and_points[PE2DID_line.NEW_POSITION],cur_index)
	projectile_instance.position = pos3D
	if node_rotation != null:
		projectile_instance.rotation = node_rotation.rotation
	if debug:
		print("projectile_instance.position: ",projectile_instance.position)
	if is_instance_valid(add_child_to_this_node):
		add_child_to_this_node.call_deferred("add_child",projectile_instance)
	else:
		add_child(projectile_instance)

## @experimental
# TODO rotation
func _get_pos_in_3D(line_point_pos:Vector2,cur_index:int) -> Vector3:
	var cur_sprite3D : Sprite3D = sprites3D[cur_index]
	var line_subviewport : SubViewport = lines2D[cur_index].get_parent()
	var use_default_xy_setting = func _use_default_xy_setting(line_point_value:float,global_pos_value:float,scale_value:float,flip_h_v:bool,line_subviewport_size_value:float) -> float:
		var value : float = line_point_value
		if flip_h_v:
			value = line_subviewport_size_value-line_point_value
		value *= scale_value
		value = value*sprites3D[cur_index].pixel_size+global_pos_value
		return value
	var use_default_z_setting = func _use_default_z_setting(global_pos_value:float,scale_value:float) -> float:
		var value : float = global_pos_value
		value *= scale_value
		return value
	# X
	var pos_x : float
	match cur_sprite3D.axis:
		Vector3.Axis.AXIS_X:
			pos_x = use_default_z_setting.call(cur_sprite3D.global_position.x,cur_sprite3D.scale.x)
		Vector3.Axis.AXIS_Y,Vector3.Axis.AXIS_Z:
			pos_x = use_default_xy_setting.call(line_point_pos.x,cur_sprite3D.global_position.x,cur_sprite3D.scale.x,cur_sprite3D.flip_h,line_subviewport.size.x)
	# Y
	var pos_y : float
	match cur_sprite3D.axis:
		Vector3.Axis.AXIS_X,Vector3.Axis.AXIS_Z:
			pos_y = use_default_xy_setting.call(line_point_pos.y,cur_sprite3D.global_position.y,cur_sprite3D.scale.y,!cur_sprite3D.flip_v,line_subviewport.size.y)
		Vector3.Axis.AXIS_Y:
			pos_y= use_default_z_setting.call(cur_sprite3D.global_position.y,cur_sprite3D.scale.y)
	# Z
	var pos_z : float
	match cur_sprite3D.axis:
		Vector3.Axis.AXIS_X:
			pos_z = use_default_xy_setting.call(-line_point_pos.x,cur_sprite3D.global_position.z,cur_sprite3D.scale.z,cur_sprite3D.flip_h,-line_subviewport.size.x)
		Vector3.Axis.AXIS_Y:
			pos_z = use_default_xy_setting.call(-line_point_pos.y,cur_sprite3D.global_position.z,cur_sprite3D.scale.z,!cur_sprite3D.flip_v,-line_subviewport.size.y)
		Vector3.Axis.AXIS_Z:
			pos_z = use_default_z_setting.call(cur_sprite3D.global_position.z,cur_sprite3D.scale.z)
	# Result
	var new_pos := Vector3(pos_x,pos_y,pos_z)
	return new_pos
