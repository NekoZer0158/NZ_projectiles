@icon("res://addons/NZ_projectiles_custom/Icons/Hit/PCRH_ID.svg")
class_name PCRH_ID
extends PCR_hit

## @experimental


func hit(atk:Variant,body:Node2D,projectile:Projectile_custom,hit_function_name:StringName,...args) -> void:
	if use_arguments:
		body.call(hit_function_name,atk,projectile.id,args)
	else:
		body.call(hit_function_name,atk,projectile.id)
