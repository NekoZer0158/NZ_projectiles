@icon("res://addons/NZ_projectiles_custom/Icons/Usable/PCRU_change_var_by_path.svg")
class_name PCRU_change_var_by_path
extends PCRU_change_var

## @experimental

@export var new_variable_resource_key : String
@export var new_variable_name : String

func use(projectile:Projectile_custom,...args) -> void:
	var new_value = projectile.get_variable_in_resource(new_variable_resource_key,new_variable_name)
	_debug_text(projectile,"Before changing",projectile.get_indexed(variable_name),new_value)
	if !args.is_empty():
		new_value = _use_args(new_value)
	match action:
		SET:
			projectile.set_indexed(variable_name,new_value)
		ADDITION:
			projectile.set_indexed(variable_name,projectile.get_indexed(variable_name)+new_value)
		SUBTRACTION:
			projectile.set_indexed(variable_name,projectile.get_indexed(variable_name)-new_value)
		MULTIPLICATION:
			projectile.set_indexed(variable_name,projectile.get_indexed(variable_name)*new_value)
		DIVISION:
			projectile.set_indexed(variable_name,projectile.get_indexed(variable_name)/new_value)
		POW:
			projectile.set_indexed(variable_name,pow(projectile.get_indexed(variable_name),new_value))
	_debug_text(projectile,"After changing",projectile.get_indexed(variable_name),new_value)
