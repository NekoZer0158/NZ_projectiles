@tool
@icon("res://addons/NZ_projectiles/Icons/Atk_change/AC_random_range.svg")
class_name AC_random_range
extends Atk_change_projectile

## Sets atk with a random value in the range

@export var min_value : int
@export var max_value : int

func _ready_step_2(parent_node:Node) -> void:
	parent_node.atk = randi_range(min_value,max_value)
