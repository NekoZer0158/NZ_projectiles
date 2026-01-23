@icon("res://addons/NZ_projectiles_custom/Icons/Hit/PCR_hit.svg")
class_name PCR_hit
extends Projectile_custom_resource

## @experimental

@export var use_arguments : bool = true

func hit(atk:Variant,body:Node2D,_projectile:Projectile_custom,hit_function_name:StringName,...args) -> void:
	if use_arguments:
		body.call(hit_function_name,atk,args)
	else:
		body.call(hit_function_name,atk)
