class_name ME_node2D_dynamic
extends ME_node2D

## @experimental
##
## Allow the projectile to follow other bodies when they enter area.[br]
## Parent node must be [Projectile] or [Projectile_extended].[br]
## [Area2D] is required as a child of this node with the name - Area2D. This is for automatic connection of signals of area and to decrease the amount of clicks.

@export var follow_character : bool = true
@export var follow_static : bool = false
@export var follow_rigid : bool = false
@export var ignore_target_out_of_area : bool = false ## If the current target (move_to_this_node2D) is exited the area then move_to_this_node2D will be set to null. Also body_exited signal will be automatically connected.
@export var target_type : TargetType
@export var switch_targets_amount : int = -1 ## Amount of times the projectile can switch current target.

var _all_targets : Array[Node2D]
var _projectile : Projectile

enum TargetType{
	CLOSEST_AT_ENTER=0, ## When a new target enters the area, the closest target will be selected as the current one (move_to_this_node2D).
	FIRST_AT_ENTER=1 ## When a new target enters the area, it will be selected as a current target (move_to_this_node2D).
	}

func _ready() -> void:
	_projectile = get_parent()
	var area_node : Area2D = $Area2D
	if !is_instance_valid(area_node):
		push_error("Area2D isn't valid or it's not named 'Area2D'")
		queue_free()
		return
	area_node.body_entered.connect(_on_area_2d_body_entered)
	if ignore_target_out_of_area:
		area_node.body_exited.connect(_on_area_2d_body_exited)
	if is_instance_valid(extra_timer):
		extra_timer.timeout.connect(_on_extra_timer_timeout.bind(_projectile))

func _found_new_target(body:Node2D) -> void:
	if !is_instance_valid(move_to_this_node2D):
		move_to_this_node2D = body
		_decrease_switch_targets_amount_if_can()
	_all_targets.append(body)
	if move_to_this_node2D != body:
		_target_type_check(body)

func _decrease_switch_targets_amount_if_can() -> void:
	if switch_targets_amount > 0:
		switch_targets_amount -= 1

func _target_type_check(body:Node2D) -> void:
	match target_type:
		TargetType.CLOSEST_AT_ENTER:
			if body.global_position.distance_to(_projectile.global_position) < move_to_this_node2D.global_position.distance_to(_projectile.global_position):
				move_to_this_node2D = body
				_decrease_switch_targets_amount_if_can()
		TargetType.FIRST_AT_ENTER:
			move_to_this_node2D = body
			_decrease_switch_targets_amount_if_can()


func _on_area_2d_body_entered(body:Node2D) -> void:
	if switch_targets_amount != 0:
		if follow_character:
			if body is CharacterBody2D:
				_found_new_target(body)
		if follow_static:
			if body is StaticBody2D:
				_found_new_target(body)
		if follow_rigid:
			if body is RigidBody2D:
				_found_new_target(body)

func _on_area_2d_body_exited(body:Node2D) -> void:
	if body in _all_targets:
		_all_targets.erase(body)
	if ignore_target_out_of_area and body == move_to_this_node2D:
		move_to_this_node2D = null
