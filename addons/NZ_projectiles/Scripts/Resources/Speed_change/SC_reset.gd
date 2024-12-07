@icon("res://addons/NZ_projectiles/Icons/Speed_change/SC_reset.svg")
class_name SC_reset
extends Speed_change_projectile
## @experimental

var cur_parent_node : Projectile

func _ready(parent_node:Projectile) -> void:
	cur_parent_node = parent_node

func change_speed(projectile_speed:int) -> int:
	cur_parent_node.r_speed_change.reset()
	cur_parent_node.r_speed_change.activate()
	return projectile_speed
