@abstract
@icon("res://addons/NZ_projectiles_custom/Icons/Usable/PCRU_change_var.svg")
class_name PCRU_change_var
extends PCR_usable

## @experimental

@export var variable_name : String = "variable"
@export_enum("=","+","-","*","/","pow") var action : int = 0
@export_enum("=","+","-","*","/","pow","ignore") var args_action_towards_value : int = 0

enum {SET,ADDITION,SUBTRACTION,MULTIPLICATION,DIVISION,POW,IGNORE}

func _use_args(new_value:Variant,...args) -> Variant:
	for i in args:
		match args_action_towards_value:
			SET:
				new_value = i
			ADDITION:
				new_value += i
			SUBTRACTION:
				new_value -= i
			MULTIPLICATION:
				new_value *= i
			SUBTRACTION:
				new_value /= i
			POW:
				new_value = pow(new_value,i)
			IGNORE:
				pass
	return new_value

func _debug_text(projectile:Projectile_custom,first_text:String,change_this_variable:Variant,new_value:Variant) -> void:
	if debug:
		print("---------------------")
		print(first_text)
		print("variable: ",change_this_variable,"| value: ",new_value)
