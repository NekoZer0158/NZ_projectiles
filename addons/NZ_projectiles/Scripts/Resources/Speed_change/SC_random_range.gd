@tool
@icon("res://addons/NZ_projectiles/Icons/Speed_change/SC_random_range.svg")
class_name SC_random_range
extends Speed_change_projectile

@export var min_value : int:
	set(value):
		min_value = clampi(value,value,max_value)
@export var max_value : int:
	set(value):
		max_value = clampi(value,min_value,value)

var cur_value : int

const CREATE_DUPLICATE : bool = true

func _ready(parent_node:Projectile) -> void:
	cur_value = randi_range(min_value,max_value)

func change_speed(_projectile_speed:int) -> int:
	return cur_value
