@abstract
@tool
@icon("res://addons/NZ_projectiles/Icons/Speed_change/SC_condition.svg")
class_name SC_condition
extends Speed_change_projectile

## By default will be used speed_change, after condition is true will be used after_condition_speed_change

@export var speed_change : Speed_change_projectile
@export var after_condition_speed_change : Speed_change_projectile ## This resource will be used after the condition is met
@export var extra_resource : Projectile_resource_extra
@export var debug : bool = false

var condition_is_true : bool = false
var _extra_was_used : bool = false
var _cur_projectile : Node

const CREATE_DUPLICATE : bool = true

func _ready(parent_node:Node) -> void:
	if ProjectileChecks.check_if_this_a_projectile(parent_node):
		if extra_resource != null:
			_cur_projectile = parent_node
		if speed_change != null:
			if speed_change.has_method("_ready"):
				speed_change = speed_change.duplicate(true)
				speed_change._ready(parent_node)
		#else:
			#push_error("No speed_change")
		if after_condition_speed_change != null:
			if after_condition_speed_change.has_method("_ready"):
				after_condition_speed_change = after_condition_speed_change.duplicate(true)
				after_condition_speed_change._ready(parent_node)
		else:
			push_error("No after_condition_speed_change")

func reset() -> void:
	_extra_was_used = false
	if speed_change != null:
		if speed_change.has_method("reset"):
			speed_change.reset()
	if after_condition_speed_change.has_method("reset"):
		after_condition_speed_change.reset()
	condition_is_true = false
	if debug:
		print(resource_name,": resource was reset | Time: ",Time.get_time_dict_from_system())

func _check_and_use_extra_resource(projectile:Node) -> void: ## Checks if extra resource exists and uses it if haven't used already
	if extra_resource != null and !_extra_was_used:
		extra_resource.use_extra(projectile)
		_extra_was_used = true

func change_speed(projectile_speed:int) -> int:
	if !condition_is_true:
		if speed_change == null:
			return projectile_speed
		speed_change.activate()
		if speed_change is SC_increase:
			if speed_change.type_of_increase == speed_change.EVERY_CALL_OF_MOVE_FUNCTION:
				return speed_change.change_speed(projectile_speed)
		return speed_change.change_speed(projectile_speed)
	_check_and_use_extra_resource(_cur_projectile)
	if after_condition_speed_change is SC_increase:
		if after_condition_speed_change.type_of_increase == after_condition_speed_change.EVERY_CALL_OF_MOVE_FUNCTION:
			return after_condition_speed_change.change_speed(projectile_speed)
	after_condition_speed_change.activate()
	return after_condition_speed_change.change_speed(projectile_speed)
