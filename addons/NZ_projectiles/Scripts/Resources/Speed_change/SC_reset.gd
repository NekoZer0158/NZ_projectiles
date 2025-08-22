@icon("res://addons/NZ_projectiles/Icons/Speed_change/SC_reset.svg")
class_name SC_reset
extends Speed_change_projectile
## @experimental

var cur_parent_node : Projectile

func _ready(parent_node:Projectile) -> void:
	cur_parent_node = parent_node

## Resets SC_condition and SC_condition_timer, creating an infinite loop (shouldn't be used as r_speed_change)
func change_speed(projectile_speed:int) -> int:
	if cur_parent_node.r_speed_change is SC_condition:
		cur_parent_node.r_speed_change.reset()
		cur_parent_node.r_speed_change.activate()
	else:
		push_error("r_speed_change should be SC_condition or SC_condition_timer")
	return projectile_speed
