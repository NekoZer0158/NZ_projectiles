@icon("res://addons/NZ_projectiles_custom/Icons/Remove/PCRR_func.svg")
class_name PCRR_func
extends PCR_remove

@export var use_args : bool = false
@export var func_name : String

func remove_projectile(projectile:Projectile_custom,args) -> void:
	if use_args:
		projectile.call(func_name,args)
	else:
		projectile.call(func_name)
