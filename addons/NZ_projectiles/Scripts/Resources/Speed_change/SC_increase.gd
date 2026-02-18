@tool
@icon("res://addons/NZ_projectiles/Icons/Speed_change/Speed_increase.svg")
class_name SC_increase
extends Speed_change_projectile

## Increases speed by step

@export var increase_to_this_amount : int = 100
@export var step : int = 5:
	set(value):
		step = clamp(value,0,abs(value))
@export_enum("Every call of move function","Every second") var type_of_increase : int = 0
@export var time_for_increase : float = 0.0: ## Does nothing if type_of_increase is not set to 'Every second'
	set(value):
		if value >= 0.0:
			time_for_increase = value
		else:
			time_for_increase = 0.0
@export var check_if_timer_is_valid : bool = true
@export var debug : bool = false

enum {EVERY_CALL_OF_MOVE_FUNCTION,EVERY_SECOND}

var timer : Timer

func _ready(parent_node:Node) -> void:
	if ProjectileChecks.check_if_this_a_projectile(parent_node):
		if type_of_increase == EVERY_SECOND:
			timer = Timer.new()
			parent_node.add_child(timer)
			timer.timeout.connect(_on_timer_timeout.bind(parent_node))

func reset() -> void:
	stop_timer()

func activate() -> void:
	if type_of_increase == EVERY_SECOND:
		if timer.is_stopped():
			timer.start(time_for_increase)
			if debug:
				print(resource_name,": timer has started | Time: ",Time.get_time_dict_from_system())

func stop_timer() -> void:
	if !check_if_timer_is_valid or is_instance_valid(timer):
		timer.stop()
		if debug:
			print(resource_name,": timer has stopped | Time: ",Time.get_time_dict_from_system())

func change_speed(projectile_speed:int) -> int:
	if type_of_increase == EVERY_CALL_OF_MOVE_FUNCTION:
		return increase_speed(projectile_speed)
	return projectile_speed

func increase_speed(projectile_speed:int) -> int:
	var new_projectile_speed := move_toward(projectile_speed,increase_to_this_amount,step)
	if abs(new_projectile_speed-increase_to_this_amount)>step or sign(new_projectile_speed) != sign(increase_to_this_amount):
		if increase_to_this_amount != 0 or not new_projectile_speed in range(-step,step):
			return new_projectile_speed
	return increase_to_this_amount

func _on_timer_timeout(projectile:Node) -> void:
	if is_instance_valid(projectile):
		projectile.speed = increase_speed(projectile.speed)
