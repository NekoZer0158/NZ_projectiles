@icon("res://addons/NZ_projectiles/Icons/Atk_change/Atk_change_func.svg")
class_name Atk_change_func
extends Atk_change_projectile

## Changes atk using a function in a resource

##There should be a function in this resource and it should return a value, like this
##[codeblock]
##func change_atk(atk:int,other_args:Array[Variant]) -> int:
##	if other_args.is_empty():
##		return atk
##	if typeof(other_args[0]) == TYPE_INT ortypeof(other_args[0]) == TYPE_FLOAT:
##		return atk*other_args.front()
##[/codeblock]
@export var resource_with_func : Resource
@export var func_name : String 
@export var extra_args : Array[Variant]

func _ready_step_2(parent_node:Node) -> void:
	parent_node.atk = resource_with_func.call(func_name,parent_node.atk,extra_args)
