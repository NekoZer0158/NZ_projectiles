@tool
@icon("res://addons/NZ_projectiles/Icons/Hit_extended/More_variables.svg")
class_name HE_more_variables
extends Hit_extended_projectile

## @experimental

@export var more_variables_from_projectile : Array[StringName]:
	set(value):
		if value.size() <= 3:
			more_variables_from_projectile = value
@export var call_function_with_array : bool = false

func call_hit_extended_function(atk:int,body:Node2D,projectile:Projectile) -> void: ## Will be changed in the future
	if more_variables_from_projectile.size() > 0:
		if call_function_with_array:
			var array_with_values : Array = []
			for i in more_variables_from_projectile:
				array_with_values.append(projectile.get(i))
			body.call(name_hit_extended,atk,array_with_values)
		else: # TODO MAKE THIS PART BETTER
			if more_variables_from_projectile.size() > 1:
				if more_variables_from_projectile.size() > 2:
					body.call(name_hit_extended,atk,projectile.get(more_variables_from_projectile[0]),projectile.get(more_variables_from_projectile[1]),projectile.get(more_variables_from_projectile[2]))
				else:
					body.call(name_hit_extended,atk,projectile.get(more_variables_from_projectile[0]),projectile.get(more_variables_from_projectile[1]))
			else:
				body.call(name_hit_extended,atk,projectile.get(more_variables_from_projectile[0]))
	else:
		push_error("no values in more_variables_from_projectile")
