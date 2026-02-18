@tool
@icon("res://addons/NZ_projectiles/Icons/Speed_change/SC_random_range.svg")
class_name SC_random_range
extends Speed_change_projectile

## Sets speed with a random value in the range

@export var min_value : int
@export var max_value : int

var cur_value : int

const CREATE_DUPLICATE : bool = true

func _ready(_parent_node:Node) -> void:
	cur_value = randi_range(min_value,max_value)

func change_speed(_projectile_speed:int) -> int:
	return cur_value
