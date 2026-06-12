@icon("res://addons/NZ_projectiles/Icons/Other/Extra/PR_extra_change_var.svg")
class_name PR_extra_change_var
extends Projectile_resource_extra

@export var variable_name : String
@export var new_value : Variant
@export_enum("Repalce","Add","Subtract") var what_to_do_with_value : int

enum {REPLACE,ADD,SUBTRACT}

func use_extra(cur_projectile:Node) -> void:
	if variable_name in cur_projectile:
		match what_to_do_with_value:
			REPLACE:
				cur_projectile.set(variable_name,new_value)
			ADD:
				cur_projectile.set(variable_name,cur_projectile.get(variable_name)+new_value)
			SUBTRACT:
				cur_projectile.set(variable_name,cur_projectile.get(variable_name)-new_value)
