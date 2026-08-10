@tool
@icon("res://addons/NZ_projectiles/Icons/Atk_change/AC_random_range.svg")
class_name AC_random_range
extends Atk_change_projectile

## Sets atk with a random value in the range

@export var min_value : int
@export var max_value : int
@export var min_value_the_same_as_atk : bool = false
@export var max_value_is_min_value_plus_max_value : bool = false

func _ready_step_2(parent_node:Node) -> void:
	if min_value_the_same_as_atk:
		if max_value_is_min_value_plus_max_value:
			parent_node.atk = randi_range(parent_node.atk,parent_node.atk+max_value)
		else:
			parent_node.atk = randi_range(parent_node.atk,max_value)
	else:
		if max_value_is_min_value_plus_max_value:
			parent_node.atk = randi_range(min_value,min_value+max_value)
		else:
			parent_node.atk = randi_range(min_value,max_value)
