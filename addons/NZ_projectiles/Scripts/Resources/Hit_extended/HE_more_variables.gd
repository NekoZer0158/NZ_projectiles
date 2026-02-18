@tool
@icon("res://addons/NZ_projectiles/Icons/Hit_extended/More_variables.svg")
class_name HE_more_variables
extends Hit_extended_projectile

## Calls hit_extended function with more variables, getting them from a projectile

## if false, the maximum amount of variables is 5, otherwise - infinite
@export var call_function_with_array : bool = false:
	set(value):
		call_function_with_array = value
@export var more_variables_from_projectile : Array[StringName]:
	set(value):
		if !call_function_with_array and value.size() > 5:
			value.resize(5)
			more_variables_from_projectile = value
		elif call_function_with_array or value.size() <= 5:
			more_variables_from_projectile = value

func call_hit_extended_function(atk:int,body:Node,projectile:Node) -> void:
	if more_variables_from_projectile.size() > 0:
		if call_function_with_array:
			var array_with_values : Array = []
			for i in more_variables_from_projectile:
				array_with_values.append(projectile.get(i))
			body.call(name_hit_extended,atk,array_with_values)
		else: # Just use array if you have more than 5 arguments
			_no_array_way_to_call_function_with_more_variables(atk,body,projectile)
	else:
		push_error("no values in more_variables_from_projectile")

func _no_array_way_to_call_function_with_more_variables(atk:int,body:Node2D,projectile:Node) -> void:
	var first_variable := projectile.get(more_variables_from_projectile[0])
	if more_variables_from_projectile.size() > 1:
		var second_variable := projectile.get(more_variables_from_projectile[1])
		if more_variables_from_projectile.size() > 2:
			var third_variable := projectile.get(more_variables_from_projectile[2])
			if more_variables_from_projectile.size() > 3:
				var fourth_variable := projectile.get(more_variables_from_projectile[3])
				if more_variables_from_projectile.size() > 4:
					var fifth_variable := projectile.get(more_variables_from_projectile[4])
					body.call(name_hit_extended,atk,first_variable,second_variable,third_variable,fourth_variable,fifth_variable)
				else:
					body.call(name_hit_extended,atk,first_variable,second_variable,third_variable,fourth_variable)
			else:
				body.call(name_hit_extended,atk,first_variable,second_variable,third_variable)
		else:
			body.call(name_hit_extended,atk,first_variable,second_variable)
	else:
		body.call(name_hit_extended,atk,first_variable)
