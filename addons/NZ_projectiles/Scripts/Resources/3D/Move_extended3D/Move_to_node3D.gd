@icon("res://addons/NZ_projectiles/Icons/3D/Move_extended3D/Move_to_node3D.svg")
class_name Move_to_node3D_projectile
extends Move_extended_projectile3D

## Moves the projectile to [Node3D]

@export var node3D_path : NodePath
@export var look_at_this_node : bool = false
@export var multiply_scale_when_dont_look : bool = false ## Will multiply speed to scale when look_at_this_node is set to false
@export var move_away : bool = false ## If true, the projecitle will move in the opposite way from the [Node3D]
@export var default_movement_if_no_node3D : bool = false ## If set to true then default movement will be used when [Node3D] instance isn't valid anymore
@export var after_reaching_node3D_movement : ProjectileEnum.AfterReachingNode
@export var reach_distance : float = 0.0
@export var cur_basis_axis : ProjectileEnum.BasisAxis = ProjectileEnum.BasisAxis.Z
@export_custom(PROPERTY_HINT_NONE,"suffix:°") var add_those_degrees : Vector3
@export var instant_look : bool = true ## If set to true then the projectile will instantly look at the node, if false then it's angle will be changed by look_speed until it's looking at the node (look_at_this_node must be set to true)
@export_range(0,360,0.001,"suffix:°") var look_speed : float = 0.0
@export_group("Extra resource","extra_")
@export var extra_resource : Projectile_resource_extra ## Will be used depending on extra_resource_usage
@export var extra_resource_usage : ProjectileEnum.ExtraResourceUsageMovement = ProjectileEnum.ExtraResourceUsageMovement.AFTER_REACHING_OR_WHEN_NO_NODE
@export_node_path("Timer") var extra_timer_path : NodePath ## Recommend to set one_shot to true
@export var extra_time : float = 0.0 ## If extra_timer_path is a path to a [Timer] and extra_time is bigger than 0 then extra_resource will be activated only after that amount of time

var move_to_this_node3D : Node3D ## Set this through [ProjectileSetter] or node3D_path
var added_degrees : bool = false

var _stop_moving : bool = false
var _extra_resource_was_used : bool = false
var _default_movement : bool = false
var _extra_timer : Timer

const CREATE_DUPLICATE : bool = true

func _ready(parent_node:Node) -> void:
	if parent_node.has_node(node3D_path):
		ProjectileSetter.set_node_to_which_projectile3D_moves_to(parent_node,parent_node.get_node(node3D_path),false,look_at_this_node,cur_basis_axis)
	if parent_node.has_node(extra_timer_path):
		_extra_timer = parent_node.get_node(extra_timer_path)
		_extra_timer.timeout.connect(_on_extra_timer_timeout.bind(parent_node))

func move_extended(projectile3D:Projectile3D,delta:float) -> void:
	if _stop_moving:
		return
	if !added_degrees:
		if add_those_degrees != Vector3.ZERO:
			projectile3D.rotation_degrees += add_those_degrees
		added_degrees = true
	if is_instance_valid(move_to_this_node3D) and !_default_movement:
		if look_at_this_node:
			if !move_away:
				projectile3D.position += ProjectileGetter.get_cur_basis_axis(cur_basis_axis,projectile3D)*projectile3D.speed*delta
			else:
				projectile3D.position -= ProjectileGetter.get_cur_basis_axis(cur_basis_axis,projectile3D)*projectile3D.speed*delta
			if instant_look:
				projectile3D.look_at(move_to_this_node3D.global_position,Vector3.UP,true)
			else:
				var _quaternion_to_cur_point : Quaternion = projectile3D.basis.looking_at(move_to_this_node3D.global_position-projectile3D.position,Vector3.UP,true).get_rotation_quaternion()
				var _euler_to_cur_point : Vector3 = _quaternion_to_cur_point.get_euler(projectile3D.rotation_order)
				projectile3D.rotation = projectile3D.rotation.move_toward(find_shortest_way_to_angle3D(projectile3D,_euler_to_cur_point),deg_to_rad(look_speed))
				if abs(projectile3D.rotation.x-PI_2)<0.07:
					projectile3D.rotation.x = 0
				if abs(projectile3D.rotation.y-PI_2)<0.07:
					projectile3D.rotation.y = 0
				if abs(projectile3D.rotation.z-PI_2)<0.07:
					projectile3D.rotation.z = 0
		else:
			if !move_away:
				if multiply_scale_when_dont_look:
					projectile3D.position += projectile3D.speed*delta*projectile3D.global_position.direction_to(move_to_this_node3D.global_position)*projectile3D.scale
				else:
					projectile3D.position += projectile3D.speed*delta*projectile3D.global_position.direction_to(move_to_this_node3D.global_position)
			else:
				if multiply_scale_when_dont_look:
					projectile3D.position -= projectile3D.speed*delta*projectile3D.global_position.direction_to(move_to_this_node3D.global_position)*projectile3D.scale
				else:
					projectile3D.position -= projectile3D.speed*delta*projectile3D.global_position.direction_to(move_to_this_node3D.global_position)
		_check_after_reaching_node3D(projectile3D)
	else:
		if default_movement_if_no_node3D or _default_movement:
			projectile3D.position += projectile3D.transform.basis.x*projectile3D.speed*delta
		if extra_resource_usage == ProjectileEnum.ExtraResourceUsageMovement.WHEN_NO_NODE or  extra_resource_usage == ProjectileEnum.ExtraResourceUsageMovement.AFTER_REACHING_OR_WHEN_NO_NODE:
			_check_timer_and_extra_resource(projectile3D)

func _check_timer_and_extra_resource(projectile3D:Projectile3D) -> void:
	if extra_resource != null and !_extra_resource_was_used:
		if _extra_timer != null:
			_extra_timer.start(extra_time)
			_extra_resource_was_used = true
		else:
			_use_extra_resource(projectile3D)

func _use_extra_resource(projectile3D:Projectile3D,force_use:bool=false) -> void: ## Checks if extra resource exists and uses it if haven't used already
	if extra_resource != null and (!_extra_resource_was_used or force_use):
		#extra_resource.projectile = projectile3D
		extra_resource.use_extra(projectile3D)
		_extra_resource_was_used = true

func _on_extra_timer_timeout(projectile3D:Projectile3D) -> void:
	_use_extra_resource(projectile3D,true)

func _check_after_reaching_node3D(projectile3D:Projectile3D) -> void:
	if after_reaching_node3D_movement != ProjectileEnum.AfterReachingNode.NOTHING or (extra_resource != null and (extra_resource_usage == ProjectileEnum.ExtraResourceUsageMovement.AFTER_REACHING_NODE or extra_resource_usage == ProjectileEnum.ExtraResourceUsageMovement.AFTER_REACHING_OR_WHEN_NO_NODE)):
		if move_to_this_node3D.global_position.distance_to(projectile3D.global_position) <= reach_distance:
			match extra_resource_usage:
				ProjectileEnum.ExtraResourceUsageMovement.AFTER_REACHING_NODE,ProjectileEnum.ExtraResourceUsageMovement.AFTER_REACHING_OR_WHEN_NO_NODE:
					_check_timer_and_extra_resource(projectile3D)
			match after_reaching_node3D_movement:
				ProjectileEnum.AfterReachingNode.DEFAULT_MOVEMENT:
					_default_movement = true
				ProjectileEnum.AfterReachingNode.STOP:
					_stop_moving = true
				ProjectileEnum.AfterReachingNode.QUEUE_FREE:
					projectile3D.queue_free()
