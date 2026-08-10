@icon("res://addons/NZ_projectiles/Icons/Move_extended/Move_to_node2D.svg")
class_name ME_node2D
extends Move_extended_projectile_node

## Moves the projectile to [Node2D]

@export var move_to_this_node2D : Node2D
@export var look_at_this_node : bool = false
@export var multiply_scale_when_dont_look : bool = false ## Will multiply speed to scale when look_at_this_node is set to false
@export var move_away : bool = false ## If true, the projecitle will move in the opposite way from the [Node2D]
@export var default_movement_if_no_node2D : bool = false ## If set to true then default movement will be used when [Node2D] instance isn't valid anymore
@export var after_reaching_node2D_movement : ProjectileEnum.AfterReachingNode
@export var reach_distance : float = 0.0
@export_range(-360,360,0.001,"suffix:°") var add_those_degrees : float = 0
@export var instant_look : bool = true ##If set to true then the projectile will instantly look at the node, if false then it's angle will be changed by look_speed until it's looking at the node (look_at_this_node must be set to true)
@export_range(0,360,0.001,"suffix:°") var look_speed : float = 0.0
@export_group("Extra resource","extra_")
@export var extra_resource : Projectile_resource_extra ## Will be used depending on extra_resource_usage
@export var extra_resource_usage : ProjectileEnum.ExtraResourceUsageMovement = ProjectileEnum.ExtraResourceUsageMovement.AFTER_REACHING_OR_WHEN_NO_NODE
@export var extra_timer :Timer ## Recommend to set one_shot to true. timeout signal will be automatically connected.

var _stopped_moving : bool = false
var _extra_resource_was_used : bool = false
var _default_movement : bool = false
var _degrees_were_added_to_projectile : bool = false

func _ready() -> void:
	var parent_node : Projectile = get_parent()
	if !is_instance_valid(move_to_this_node2D):
		push_error("move_to_this_node2D isn't valid")
	if is_instance_valid(extra_timer):
		extra_timer.timeout.connect(_on_extra_timer_timeout.bind(parent_node))

func move_extended(projectile:Projectile,delta:float) -> void:
	if _stopped_moving:
		return
	if !_degrees_were_added_to_projectile:
		if add_those_degrees != 0:
			projectile.rotation_degrees += add_those_degrees
		_degrees_were_added_to_projectile = true
	if is_instance_valid(move_to_this_node2D) and !_default_movement:
		if look_at_this_node:
			if !move_away:
				projectile.position += projectile.transform.x*projectile.speed*delta
			else:
				projectile.position -= projectile.transform.x*projectile.speed*delta
			if instant_look:
				projectile.look_at(move_to_this_node2D.global_position)
			else:
				projectile.rotation = move_toward(projectile.rotation,find_shortest_way_to_angle(projectile,projectile.global_position.angle_to_point(move_to_this_node2D.global_position)),deg_to_rad(look_speed))
				if abs(projectile.rotation-PI_2)<0.07 or projectile.rotation>=PI_2:
					projectile.rotation = 0
		else:
			if !move_away:
				if multiply_scale_when_dont_look:
					projectile.position += projectile.speed*delta*projectile.global_position.direction_to(move_to_this_node2D.global_position)*projectile.scale
				else:
					projectile.position += projectile.speed*delta*projectile.global_position.direction_to(move_to_this_node2D.global_position)
			else:
				if multiply_scale_when_dont_look:
					projectile.position -= projectile.speed*delta*projectile.global_position.direction_to(move_to_this_node2D.global_position)*projectile.scale
				else:
					projectile.position -= projectile.speed*delta*projectile.global_position.direction_to(move_to_this_node2D.global_position)
		_check_after_reaching_node2D(projectile)
	else:
		if default_movement_if_no_node2D or _default_movement:
			projectile.position += projectile.transform.x*projectile.speed*delta
		if extra_resource_usage == ProjectileEnum.ExtraResourceUsageMovement.WHEN_NO_NODE or  extra_resource_usage == ProjectileEnum.ExtraResourceUsageMovement.AFTER_REACHING_OR_WHEN_NO_NODE:
			_check_timer_and_extra_resource(projectile)

func _check_timer_and_extra_resource(projectile:Projectile) -> void:
	if extra_resource != null and !_extra_resource_was_used:
		if is_instance_valid(extra_timer):
			extra_timer.start()
			_extra_resource_was_used = true
		else:
			_use_extra_resource(projectile)

func _use_extra_resource(projectile:Projectile,force_use:bool=false) -> void:
	if extra_resource != null and (!_extra_resource_was_used or force_use):
		#extra_resource.projectile = projectile
		extra_resource.use_extra(projectile)
		_extra_resource_was_used = true

func _on_extra_timer_timeout(projectile:Projectile) -> void:
	_use_extra_resource(projectile,true)

func _check_after_reaching_node2D(projectile:Projectile) -> void:
	if after_reaching_node2D_movement != ProjectileEnum.AfterReachingNode.NOTHING or (extra_resource != null and (extra_resource_usage == ProjectileEnum.ExtraResourceUsageMovement.AFTER_REACHING_NODE or extra_resource_usage == ProjectileEnum.ExtraResourceUsageMovement.AFTER_REACHING_OR_WHEN_NO_NODE)):
		if move_to_this_node2D.global_position.distance_to(projectile.global_position) <= reach_distance:
			match extra_resource_usage:
				ProjectileEnum.ExtraResourceUsageMovement.AFTER_REACHING_NODE,ProjectileEnum.ExtraResourceUsageMovement.AFTER_REACHING_OR_WHEN_NO_NODE:
					_check_timer_and_extra_resource(projectile)
			match after_reaching_node2D_movement:
				ProjectileEnum.AfterReachingNode.DEFAULT_MOVEMENT:
					_default_movement = true
				ProjectileEnum.AfterReachingNode.STOP:
					_stopped_moving = true
				ProjectileEnum.AfterReachingNode.QUEUE_FREE:
					projectile.queue_free()
