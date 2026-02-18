@icon("res://addons/NZ_projectiles/Icons/Speed_change/SC_reset.svg")
class_name SC_reset
extends Speed_change_projectile

## Resets a resource (it should be SC_condition)
##
## @experimental
## Shouldn't be used as r_speed_change, this is only for [color=mediumturquoise]SC_condition[/color] and [color=mediumturquoise]SC_condition_timer[/color]

## Amount of times reset can be activated
@export var reset_limit : int = -1
@export var resource_after_limit : Speed_change_projectile

var cur_parent_node : Node

func _ready(parent_node:Node) -> void:
	if ProjectileChecks.check_if_this_a_projectile(parent_node):
		cur_parent_node = parent_node

## Resets SC_condition and SC_condition_timer, creating an infinite loop (shouldn't be used as r_speed_change)
func change_speed(projectile_speed:int) -> int:
	if reset_limit == 0:
		if resource_after_limit == null:
			return projectile_speed
		return resource_after_limit.change_speed(projectile_speed)
	if cur_parent_node.r_speed_change is SC_condition:
		cur_parent_node.r_speed_change.reset()
		cur_parent_node.r_speed_change.activate()
		if reset_limit > 0:
			reset_limit -= 1
	else:
		push_error("r_speed_change should be SC_condition or SC_condition_timer")
	return projectile_speed
