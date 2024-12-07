@icon("res://addons/NZ_projectiles/Icons/Hit_extended/Position.svg")
class_name HE_position
extends Hit_extended_projectile

func call_hit_extended_function(atk:int,body:Node2D,projectile:Projectile) -> void:
	body.call(name_hit_extended,atk,projectile.global_position)
