@icon("res://addons/NZ_projectiles/Icons/Atk_change/AC_time_multiplier.svg")
class_name ACT_multiplier
extends AC_time

## Changes atk through time by multiplying to it atk_step

func _on_timer_timeout(parent_node:Node) -> void:
	var new_attack : int = parent_node.atk*atk_step
	if new_attack > increase_atk_to_this:
		new_attack = increase_atk_to_this
	parent_node.atk = new_attack
	if debug:
		print_debug(parent_node.name,": ",parent_node.atk)
	if parent_node.atk == increase_atk_to_this:
		timer.stop()
