@tool
@icon("res://addons/NZ_projectiles/Icons/Atk_change/AC_time.svg")
class_name AC_time
extends Atk_change_projectile

## Changes atk through time by adding to it atk_step

@export var increase_atk_to_this : int = 5
@export var atk_step : int = 1:
	set(value):
		atk_step = clamp(value,0,abs(value))
@export var time : float:
	set(value):
		if value >= 0:
			time = value
		else:
			time = 0
@export var extra_resource : Projectile_resource_extra
@export var debug : bool = false

var timer : Timer

func _ready_step_2(parent_node:Node) -> void:
	if extra_resource != null:
		extra_resource.projectile = parent_node
	timer = Timer.new()
	parent_node.add_child(timer)
	timer.timeout.connect(_on_timer_timeout.bind(parent_node))
	timer.start(time)

func _check_and_use_extra_resource() -> void:
	if extra_resource != null:
		extra_resource.use_extra()

func _on_timer_timeout(parent_node:Node) -> void:
	parent_node.atk = move_toward(parent_node.atk,increase_atk_to_this,atk_step)
	if debug:
		print(parent_node.name,": ",parent_node.atk)
	if parent_node.atk == increase_atk_to_this:
		_check_and_use_extra_resource()
		timer.stop()
