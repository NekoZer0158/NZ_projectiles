@icon("res://addons/NZ_projectiles/Icons/Atk_change/ACT_func.svg")
@tool
class_name ACT_func
extends AC_time

## Changes atk using a function in a resource, function should return a value

##There should be a function in this resource and it should return a value, like this
##[codeblock]
##func change_atk(atk:int,atk_step:int) -> int:
##	return (atk+atk_step)-1
##[/codeblock]
@export var resource_with_func : Resource
@export var func_name : String
@export var allow_bigger : bool = false
@export var check_if_timer_is_valid : bool = true

func _on_timer_timeout(parent_node:Node) -> void:
	var new_atk : int = resource_with_func.call(func_name,parent_node.atk,atk_step)
	if new_atk > increase_atk_to_this and !allow_bigger:
		parent_node.atk = increase_atk_to_this
	else:
		parent_node.atk = new_atk
	if debug:
		print(parent_node.name," atk:",parent_node.atk)
	if parent_node.atk >= increase_atk_to_this:
		if !check_if_timer_is_valid or is_instance_valid(timer):
			timer.stop()
