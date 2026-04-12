@icon("res://addons/NZ_projectiles/Icons/Move_extended/Move_to_node2D.svg")
class_name Move_to_node2D_projectile
extends Move_extended_projectile

## Moves the projectile to [Node2D]

@export var node2D_path : NodePath
@export var look_at_this_node : bool = false
@export var multiply_scale_when_dont_look : bool = false
@export var move_away : bool = false ## If true, the projecitle will move in the opposite way from the [Node2D]
@export var default_movement_if_no_node2D : bool = false
@export var after_reaching_node2D_movement : ProjectileEnum.AfterReachingNode
@export var reach_distance : float = 0.0
@export_range(-360,360,0.5,"suffix:°") var add_those_degrees : float = 0
@export_group("Extra resource","extra_")
@export var extra_resource : Projectile_resource_extra ## Will be used depending on extra_resource_usage
@export var extra_resource_usage : ProjectileEnum.ExtraResourceUsageMovement = ProjectileEnum.ExtraResourceUsageMovement.AFTER_REACHING_OR_WHEN_NO_NODE
@export var extra_timer_path : NodePath ## Must be a [Timer][br]Also set one_shot to true
@export var extra_time : float = 0.0 ## If extra_timer_path is a path to a [Timer] and extra_time is bigger than 0 then extra_resource will be activated only after that amount of time

var move_to_this_node2D : Node2D ## Set this through [ProjectileSetter] or node2D_path
var added_degrees : bool = false
var _stop_moving : bool = false
var _extra_resource_was_used : bool = false
var _default_movement : bool = false
var _extra_timer : Timer

const CREATE_DUPLICATE : bool = true

func _ready(parent_node:Node) -> void:
	if parent_node.has_node(node2D_path):
		ProjectileSetter.set_node_to_which_projectile_moves_to(parent_node,parent_node.get_node(node2D_path),false,look_at_this_node)
	if parent_node.has_node(extra_timer_path):
		_extra_timer = parent_node.get_node(extra_timer_path)
		_extra_timer.timeout.connect(_on_extra_timer_timeout.bind(parent_node))

func move_extended(projectile:Projectile,delta:float) -> void:
	if _stop_moving:
		return
	if !added_degrees:
		if add_those_degrees != 0:
			projectile.rotation_degrees += add_those_degrees
		added_degrees = true
	if is_instance_valid(move_to_this_node2D) and !_default_movement:
		if look_at_this_node:
			if !move_away:
				projectile.position += projectile.transform.x*projectile.speed*delta
			else:
				projectile.position -= projectile.transform.x*projectile.speed*delta
			projectile.look_at(move_to_this_node2D.global_position)
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
		if _extra_timer != null:
			_extra_timer.start(extra_time)
			_extra_resource_was_used = true
		else:
			_use_extra_resource(projectile)

func _use_extra_resource(projectile:Projectile,force_use:bool=false) -> void:
	if extra_resource != null and (!_extra_resource_was_used or force_use):
		extra_resource.projectile = projectile
		extra_resource.use_extra()
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
				ProjectileEnum.AfterReachingNode.STOP:
					_stop_moving = true
				ProjectileEnum.AfterReachingNode.DEFAULT_MOVEMENT:
					_default_movement = true
				ProjectileEnum.AfterReachingNode.QUEUE_FREE:
					projectile.queue_free()
