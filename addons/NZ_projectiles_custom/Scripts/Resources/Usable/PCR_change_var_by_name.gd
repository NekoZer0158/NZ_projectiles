@icon("res://addons/NZ_projectiles_custom/Icons/Usable/PCRU_change_var_by_name.svg")
class_name PCRU_change_var_by_name
extends PCRU_change_var

## @experimental

@export var value : Variant

func use(projectile:Projectile_custom,...args) -> void:
	var new_value = value
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
