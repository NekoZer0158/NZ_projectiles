@icon("res://addons/NZ_projectiles/Icons/Other/Extra/PR_extra_change_var.svg")
class_name PR_extra_change_var
extends Projectile_resource_extra

@export var variable_name : String
@export var new_value : Variant

func use_extra() -> void:
	if variable_name in projectile:
		projectile.set(variable_name,new_value)
