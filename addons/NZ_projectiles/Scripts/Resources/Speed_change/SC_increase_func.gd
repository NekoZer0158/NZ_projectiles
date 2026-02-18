class_name SC_increase_func
extends SC_increase

## Changes speed by calling a function in a resource

## There should be a function in this resource, like this
##[codeblock]
##func change_speed(cur_speed:int,step:int) -> int:
##	return (cur_speed+step)-1
##[/codeblock]
@export var resource_with_func : Resource
@export var func_name : String
@export var allow_bigger : bool = false

func increase_speed(projectile_speed:int) -> int:
	if projectile_speed >= increase_to_this_amount:
		return projectile_speed
	var new_projectile_speed := resource_with_func.call(func_name,projectile_speed,step)
	if debug:
		print("cur_speed: ",projectile_speed," | new_speed: ",new_projectile_speed," | increase_to_this_amount: ",increase_to_this_amount)
	if new_projectile_speed >= increase_to_this_amount:
		stop_timer()
		if !allow_bigger:
			new_projectile_speed = increase_to_this_amount
	return new_projectile_speed
