@icon("res://addons/NZ_projectiles/Icons/Hit_extended/ID.svg")
class_name HE_ID
extends Hit_extended_projectile

## Calls hit_extended function with atk and projectile ID

func call_hit_extended_function(atk:int,body:Node,projectile:Node) -> void:
	body.call(name_hit_extended,atk,projectile.id)
