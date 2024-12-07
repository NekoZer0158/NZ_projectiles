@tool
@icon("res://addons/NZ_projectiles/Icons/Atk_change/AC_random_range.svg")
class_name AC_random_range
extends Atk_change_projectile

@export var min_value : int:
	set(value):
		min_value = clampi(value,value,max_value)
@export var max_value : int:
	set(value):
		max_value = clampi(value,min_value,value)

func _ready(parent_node:Projectile) -> void:
	parent_node.atk = randi_range(min_value,max_value)
